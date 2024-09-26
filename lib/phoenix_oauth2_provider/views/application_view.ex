defmodule PhoenixOauth2Provider.ApplicationView do
  use PhoenixOauth2Provider.View

  template(
    "edit.html",
    """
    <h1>Edit Application</h1>

    <%%= render "form.html", Map.put(assigns, :action, Routes.oauth_application_path(@conn, :update, @changeset.data)) %>

    <span><.link href={Routes.oauth_application_path(@conn, :index)}></.link></span>
    """
  )

  template(
    "form.html",
    """
    <.form for={@form}>
    <%%= if @changeset.action do %>
        <div class="alert alert-danger">
          <p>Oops, something went wrong! Please check the errors below.</p>
        </div>
    <%% end %>

        <.input field={@form[:name]}  label="Name" required />
        <.input field={@form[:redirect_uri]}  label="Redirect URI" required />
      <span class="help-block">Use one line per URI</span>
        <%%= if is_nil(@native_redirect_uri) do %>
            <span class="help-block">
              Use <code><%%= @native_redirect_uri %></code> for local tests
            </span>
        <%% end %>

        <.input field={@form[:scopes]}  label="Scopes" required />
      <span class="help-block">
        Separate scopes with spaces. Leave blank to use the default scopes.
      </span>

      <div>
        <input type="submit" "Save">
      </div>
    <.form>
    """
  )

  template(
    "index.html",
    """
    <h1>Your applications</h1>

    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Callback URL</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <%%= for application <- @applications do %>
            <tr>
              <td><.link href={Routes.oauth_application_path(@conn, :show, application)}><%%= application.name %></.link></td>
              <td><%%= application.redirect_uri %></td>
              <td>
                <.link href={Routes.oauth_application_path(@conn, :edit, application)}>Edit</.link>
                <.link href={Routes.oauth_application_path(@conn, :delete, application)}>Delete</.link>
              </td>
            </tr>
        <%% end %>
      </tbody>
    </table>

    <span><.link href={Routes.oauth_application_path(@conn, :new)}>New Application</.link></span>
    """
  )

  template(
    "new.html",
    """
    <h1>New Application</h1>

    <%%= render "form.html", Map.put(assigns, :action, Routes.oauth_application_path(@conn, :create)) %>

    <span><.link href={Routes.oauth_application_path(@conn, :index)}>Back<.link></span>
    """
  )

  template("show.html", """
  <h1>Show Application</h1>

  <ul>
    <li>
      <strong>Name:</strong>
      <%%= @application.name %>
    </li>
    <li>
      <strong>ID:</strong>
      <%%= @application.uid %>
    </li>
    <li>
      <strong>Secret:</strong>
      <%%= @application.secret %>
    </li>
    <li>
      <strong>Scopes:</strong>
      <%%= @application.scopes %>
    </li>
    <li>
      <strong>Callback urls:</strong>
      <table class="table">
        <tbody>
          <%%= for redirect_uri <- String.split(@application.redirect_uri) do %>
                  <tr>
                    <td>
                      <code><%%= redirect_uri %></code>
                    </td>
                    <td>
                      <.link href={Routes.oauth_authorization_path(@conn, :new, client_id: @application.uid, redirect_uri: redirect_uri, response_type: "code", scope: @application.scopes)} target="_blank">New?</.link>
                    </td>
                  </tr>
          <%% end %>
        </tbody>
      </table>
    </li>
  </ul>

  <span><.link href={Routes.oauth_application_path(@conn, :edit, @application)}>Edit</.link></span>
  <span><.link href={Routes.oauth_application_path(@conn, :index)}>Index</.link></span>
  """)
end
