 defmodule ElixirGistWeb.CreateGistLive do
   @moduledoc false

   use ElixirGistWeb, :live_view

    def mount(_params, _session, socket) do
      {:ok, socket}
    end
  end
