# ImopiCrawler

This is a simple crawler to fetch all the real estate properties at "Imóveis no Piauí" Web Site.
It contains a filter function to exclude real state properties witch doesn't have a details url defined or price info, thus don't hope to find any property where the price is not available.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `imopi_crawler` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:imopi_crawler, "~> 0.1.0"}]
    end
    ```

  2. Ensure `imopi_crawler` is started before your application:

    ```elixir
    def application do
      [applications: [:imopi_crawler]]
    end
    ```

# How to use

You can fetch all the properties by just running:

  ```elixir
  ImopiCrawler.properties
  ```

This command will fetch all the properties listed at the site and return as a List of Structs.

You can also customize the base path and the page number to start fetching the properties.

  ```elixir
  ImopiCrawler.properties(base_url, page)
  ```

Let's suppose you already have a list of properties and would like to take that in count in the returned value, you can do this by running:

  ```elixir
  ImopiCrawler.properties(base_url, page, [YourListHere])
  ```

By default this package if configure to retry 10 times the same url if an HTTP Exception is raised, you can change that by running:

  ```elixir
  ImopiCrawler.properties(base_url, page, [], number_of_retries)
  ```

Default configuration:

```elixir
@base_url "http://www.imoveisnopiaui.com/comprar/a-z/"
@max_retries 10
@starting_list []
```

Enjoy yourself!

You have any suggestions make a pull request, they're welcome!

## Next steps

Fetch the pages concurrently.

Make this crawler reusable for other websites.
