defmodule DummyWeb do
  @moduledoc false

  def controller do
    quote do
      use Phoenix.Controller,
        formats: [:html],
        layouts: [html: DummyWeb.Layouts]
    end
  end

  def html do
    quote do
      use Phoenix.Component

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_csrf_token: 0, view_module: 1, view_template: 1]

      # Include general helpers for rendering HTML
      unquote(html_helpers())
    end
  end

  defp html_helpers do
    quote do
      # HTML escaping functionality
      import Phoenix.HTML

      # # Routes generation with the ~p sigil
      # unquote(verified_routes())
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
