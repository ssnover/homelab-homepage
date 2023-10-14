const SERVICES_CONF: &str = include_str!(concat!(env!("CARGO_MANIFEST_DIR"), "/services.conf"));
lazy_static::lazy_static! {
    pub static ref SERVICES: Vec<Service<'static>> = parse_services(SERVICES_CONF);
}

fn parse_services<'a>(conf: &'a str) -> Vec<Service<'a>> {
    conf.lines()
        .into_iter()
        .filter_map(|line| {
            line.find(',').map(|idx| Service {
                name: &line[..idx],
                subdomain: &line[idx + 1..],
            })
        })
        .collect()
}

#[derive(Clone, Debug)]
pub struct Service<'a> {
    pub name: &'a str,
    pub subdomain: &'a str,
}
