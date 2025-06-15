mod cef;

use cef::{
    _cef_request_context_t, _cef_request_t, _cef_urlrequest_client_t, cef_string_userfree_utf16_t, cef_urlrequest_t,
};
use lazy_static::lazy_static;
use libc::{addrinfo, c_char, dlsym, EAI_FAIL, RTLD_NEXT};
use regex::RegexSet;
use serde::Deserialize;
use std::{env, ffi::CStr, fs::read_to_string, mem, path::PathBuf, ptr::null, slice::from_raw_parts, string::String};

macro_rules! hook {
    ($function_name:ident($($parameter_name:ident: $parameter_type:ty),*) -> $return_type:ty => $new_function_name:ident $body:block) => {
        lazy_static! {
            static ref $new_function_name: fn($($parameter_type),*) -> $return_type = unsafe {
                let function_name = CStr::from_bytes_with_nul(concat!(stringify!($function_name), "\0").as_bytes()).unwrap();
                let function_pointer = dlsym(RTLD_NEXT, function_name.as_ptr());
                if function_pointer.is_null() {
                    panic!("[*] Error: Unable to find function \"{}\"", stringify!($function_name));
                }
                mem::transmute(function_pointer)
            };
        }

        #[no_mangle]
        pub unsafe extern "C" fn $function_name($($parameter_name: $parameter_type),*) -> $return_type {
            $body
        }
    }
}

#[derive(Deserialize)]
struct Config {
    #[serde(with = "serde_regex")]
    allowlist: RegexSet,
    #[serde(with = "serde_regex")]
    denylist: RegexSet,
}

lazy_static! {
    static ref CONFIG: Config = {
        let config_paths = vec![
            PathBuf::from("config.toml"),
            match env::var("XDG_CONFIG_HOME") {
                Ok(xdg_config_home) => PathBuf::from(xdg_config_home),
                #[allow(deprecated)] // std::env::home_dir() is only broken on Windows
                Err(_) => PathBuf::from(env::home_dir().unwrap()).join(".config")
            }.join("spotify-adblock/config.toml"),
            PathBuf::from("/etc/spotify-adblock/config.toml"),
        ];

        if let Some(path) = config_paths.into_iter().find(|path| path.exists()) {
            println!("[*] Config file: {}", path.to_str().unwrap());
            match read_to_string(path) {
                Ok(config_string) => match toml::from_str(&config_string) {
                    Ok(config) => {
                        return config;
                    }
                    Err(error) => {
                        println!("[*] Error: Parse config file ({})", error);
                    }
                },
                Err(error) => {
                    println!("[*] Error: Read config file ({})", error);
                }
            }
        } else {
            println!("[*] Error: No config file");
        };
        Config {
            allowlist: RegexSet::empty(),
            denylist: RegexSet::empty(),
        }
    };
}

hook! {
    getaddrinfo(node: *const c_char, service: *const c_char, hints: *const addrinfo, res: *const *const addrinfo) -> i32 => REAL_GETADDRINFO {
        let domain = CStr::from_ptr(node).to_str().unwrap();

        if CONFIG.allowlist.is_match(&domain) {
            println!("[+] getaddrinfo:\t\t {}", domain);
            REAL_GETADDRINFO(node, service, hints, res)
        } else {
            println!("[-] getaddrinfo:\t\t {}", domain);
            EAI_FAIL
        }
    }
}

hook! {
    cef_urlrequest_create(request: *mut _cef_request_t, client: *const _cef_urlrequest_client_t, request_context: *const _cef_request_context_t) -> *const cef_urlrequest_t => REAL_CEF_URLREQUEST_CREATE {
        let url_cef = (*request).get_url.unwrap()(request);
        let url_utf16 = from_raw_parts((*url_cef).str_, (*url_cef).length as usize);
        let url = String::from_utf16(url_utf16).unwrap();
        cef_string_userfree_utf16_free(url_cef);

        if CONFIG.denylist.is_match(&url) {
            println!("[-] cef_urlrequest_create:\t {}", url);
            null()
        } else {
            println!("[+] cef_urlrequest_create:\t {}", url);
            REAL_CEF_URLREQUEST_CREATE(request, client, request_context)
        }
    }
}

hook! {
    cef_string_userfree_utf16_free(_str: cef_string_userfree_utf16_t) -> () => REAL_CEF_STRING_USERFREE_UTF16_FREE {
        REAL_CEF_STRING_USERFREE_UTF16_FREE(_str);
    }
}
