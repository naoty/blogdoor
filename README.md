# Blogdoor

Blogdoor is a toolkit for easily previewing posts.

## Installation

```sh
$ gem install blogdoor
```

## Usage

At your workspace, run `blogdoor start`.

```sh
$ cd path/to/workspace
$ blogdoor start
```

This command builds HTML files from your posts written by markdown and `layout.erb`. There are built HTML files under `builds/` at current directory. If you want to preview them, open them by browser.

Additionally, the command starts websocket server on `localhost:5678` for livereload. When a file has changed, browser will automatically reload the page.

## Example

Below is the example of `layout.erb`. Feel free to customize it so that it looks like your blog.

```erb
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title><%= @title %></title>
</head>
<body>
  <article>
    <p class="when"><%= @created_at %></p>
    <h1><%= @title %></h1>
    <div class="article-body">
      <%= @content %>
    </div>
  </article>
</body>
</html>
```

- `@title`: is injected the name of changed file.
- `@created_at`: is injected the last update date of changed file.
- `@content`: is injected the content of changed file.

