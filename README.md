# Personal portfolio / blog

This is the repo of my personal portfolio, currently hosted on [Fly](https:www.fly.io) and available [here](https://simonricard.com)

## Local installation

If you would to run this locally, you will need a few dependencies.

- First, you will Elixir and Erlang (I used 1.16 in this repo but an older version could also work).
- You will also need [just](https://github.com/casey/just) to run the commands.
- Finally, `node` for serving your static files. You can use something else but you will need to modify the `justfile` to reflect what you chose.

Once your deps installed, run `mix deps.get` within the folder. Then running `just start` should build the files and serve them on port `8000`.

Note: Source files for photos are a submodule. If you want to use your own photos, simply add your own `photos` folder.
