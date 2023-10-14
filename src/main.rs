use yew::prelude::*;

mod services;

#[function_component(App)]
fn app() -> Html {
    let services = services::SERVICES
        .iter()
        .map(|svc| {
            html! {
                <div class="service">
                    <a href={format!("https://{}.homelab0", svc.subdomain)}>{svc.name}</a>
                </div>
            }
        })
        .collect::<Vec<Html>>();

    html! {
        <>
            <h1>{ "Available Services" }</h1>
            { services }
        </>
    }
}

fn main() {
    yew::Renderer::<App>::new().render();
}
