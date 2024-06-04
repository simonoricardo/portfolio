import Config

config :esbuild,
  version: "0.21.3",
  default: [
    args:
      ~w(app.js glightbox.js ./css/glightbox.css ./css/makeup.css --bundle --target=es2016 --outdir=../output/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../output/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]
