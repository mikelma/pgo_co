use std::collections::HashMap;
use std::fs::File;
use std::io::prelude::*;
use std::sync::{Arc, Mutex};

struct TabledData {
    pub seq_data: HashMap<String, Vec<String>>,
    pub attrs: HashMap<String, String>,

    pub log_path: String,
}

lazy_static! {
    static ref DATA: Arc<Mutex<TabledData>> = Arc::new(Mutex::new(TabledData::default()));
}

impl Default for TabledData {
    fn default() -> Self {
        Self {
            seq_data: HashMap::default(),
            attrs: HashMap::default(),
            log_path: ".".into(),
        }
    }
}

pub fn log<T: ToString>(key: &str, value: T) {
    let exists = DATA.lock().unwrap().seq_data.contains_key(key);

    if exists {
        DATA.lock()
            .unwrap()
            .seq_data
            .get_mut(&key.to_string())
            .unwrap()
            .push(value.to_string());
    } else {
        DATA.lock()
            .unwrap()
            .seq_data
            .insert(key.to_string(), vec![value.to_string()]);
    }
}

pub fn set_attr<T: ToString>(key: &str, value: T) {
    DATA.lock()
        .unwrap()
        .attrs
        .insert(key.to_string(), value.to_string());
}

pub fn set_log_dir<T: ToString>(dir: T) {
    DATA.lock().unwrap().log_path = dir.to_string();
}

pub fn write() {
    let r = rand::random::<usize>();
    set_attr("id", r);
    let algo = DATA
        .lock()
        .unwrap()
        .attrs
        .get("algorithm")
        .unwrap_or(&"unknown".to_string())
        .clone();
    let instance = DATA
        .lock()
        .unwrap()
        .attrs
        .get("instance")
        .unwrap_or(&"unknown".to_string())
        .clone();
    let function = DATA
        .lock()
        .unwrap()
        .attrs
        .get("function")
        .unwrap_or(&"function".to_string())
        .clone();
    let dir = DATA.lock().unwrap().log_path.clone();

    let fname = format!("{dir}/{r}-{algo}-{instance}:{function}.csv");
    let mut file = File::create(&fname).expect(format!("Cannot create log file: {fname}").as_str());

    {
        let data = &DATA.lock().unwrap();

        let mut cols = data
            .seq_data
            .keys()
            .chain(data.attrs.keys())
            .map(|v| v.as_str())
            .collect::<Vec<&str>>();
        cols.sort();

        // print header
        // println!("{}", cols.join(",").unwrap());
        writeln!(file, "{}", cols.join(",")).unwrap();

        let n = if data.seq_data.is_empty() {
            1
        } else {
            data.seq_data
                .get(data.seq_data.keys().nth(0).unwrap())
                .unwrap()
                .len()
        };

        for i in 0..n {
            let values = cols
                .iter()
                .map(|c| match data.attrs.get(*c) {
                    Some(v) => v.as_str(),
                    None => data.seq_data.get(*c).unwrap()[i].as_str(),
                })
                .collect::<Vec<&str>>();
            //println!("{}", values.join(","));
            writeln!(file, "{}", values.join(",")).unwrap();
        }
    }

    DATA.lock().unwrap().seq_data.clear();
    DATA.lock().unwrap().attrs.clear();
}
