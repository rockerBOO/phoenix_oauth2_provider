defmodule PhoenixOauth2Provider.AuthorizationView do
  use PhoenixOauth2Provider.View

  template(
    "error.html",
    """
    <h1>An error has occurred</h1>

    <div>
      <p><%%= @error[:error_description] %></p>
    </div>
    """
  )

  template(
    "new.html",
    """
    <h1>Authorize <strong><%%= @client.name %></strong> to use your account?</h1>

    <div>
      <p>This application will be able to:</p>
      <ul>
    <%%= for scope <- @scopes do %>
        <li><%%= scope %></li>
    <%% end %>
      </ul>
    </div>

    <div>
      <.form for={Routes.oauth_authorization_path(@conn, :create)}>
        <.input field={@form[:client_id]} type="hidden" />
        <.input field={@form[:redirect_uri]} type="hidden"  />
        <.input field={@form[:state]} type="hidden" />
        <.input field={@form[:response_type]} type="hidden"  />
        <.input field={@form[:scope]} type="hidden"  />
        <input type="submit" value="Authorize" />
      <.form>
      <.form for={Routes.oauth_authorization_path(@conn, :delete)>
        <.input field={@form[:client_id]} type="hidden" />
        <.input field={@form[:redirect_uri]} type="hidden"  />
        <.input field={@form[:state]} type="hidden" />
        <.input field={@form[:response_type]} type="hidden"  />
        <.input field={@form[:scope]} type="hidden"  />
        <input type="submit" value="Deny" />
      <.form>
    </div>
    """
  )

  template(
    "show.html",
    """
    <h1>Authorization code</h1>

    <code><%%= @code %></code>
    """
  )
end
