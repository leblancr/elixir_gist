defmodule ElixirGistWeb.CreateGistLive do
  @moduledoc """
  The module defines a LiveView for creating a gist.
  The use ElixirGistWeb, :live_view macro imports the necessary functionality for Phoenix LiveView,
  such as managing socket state, handling events, and rendering templates.
  """

  use ElixirGistWeb, :live_view
  import Phoenix.HTML.Form

  alias ElixirGist.{Gists, Gists.Gist}

  @doc"""
  mount/3 is called when the LiveView is first mounted. This is where the initial state of the LiveView is set up.
  to_form(Gists.change_gist(%Gist{})) generates a form object based on the empty Gist struct, prepared for changes.
  assign/3 assigns the form to the socket, making it available for rendering.

  Gists.change_gist(%Gist{}): This creates a changeset for a new Gist (empty values for the fields).
  to_form(Gists.change_gist(%Gist{})): Converts the changeset into a form structure that Phoenix can work with.
  assign(socket, form: ...): The assign function is used to assign data (in this case, the form) to the socket.
  This makes it available to the template or LiveView.

  In LiveView, data you assign to the socket becomes accessible to your templates by using the @ symbol (e.g., @form).

  the changeset is passed to to_form/1 which converts the changeset into
  a format Phoenix can use for rendering an HTML form.
  to_form/1 function takes the changeset and prepares it to be used as a form in LiveView

  to_form/1 doesn't create a complete HTML page, it creates a form structure that Phoenix can use to generate the HTML.

  form: is available as @form in the template.
  """
  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        form: to_form(Gists.change_gist(%Gist{})) # changeset/2 is being called
      )

    {:ok, socket}
  end

  def handle_event("validate", %{"gist" => params}, socket) do
    changeset =
      %Gist{}
      |> Gists.change_gist(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end

  def handle_event("create", %{"gist" => params}, socket) do
    case Gists.create_gist(socket.assigns.current_user, params) do
      {:ok, _gist} ->
        changeset = Gists.change_gist(%Gist{})
        {:noreply, assign(socket, :form, to_form(changeset))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end
end