FROM rust:1.73-slim-bullseye as builder
WORKDIR /app
RUN cargo install miniserve
RUN cargo install trunk
RUN rustup target add wasm32-unknown-unknown
COPY . .
RUN trunk build

FROM debian:bullseye-slim as runtime
WORKDIR /app

RUN apt-get update -y \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/dist/* /app
COPY --from=builder /usr/local/cargo/bin/miniserve /app/miniserve
ENTRYPOINT ["/app/miniserve", "--spa", "--index", "index.html"]