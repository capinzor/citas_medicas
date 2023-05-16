defmodule CitasAppWeb.Router do
  alias CitasAppWeb.CitaController
  alias CitasAppWeb.PacienteController
  use CitasAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    resources "/pacientes", PacienteController, except: [:edit, :new, :update]
    put "/pacientes/:id", PacienteController, :update
    put "/citas/:id", CitaController, :update
    resources "/citas", CitaController, except: [:edit, :new, :update]

    #get "/pedidodeusuario/:id", UsuarioController, :get_pedidos
    get "/citapordiagnostico/:diagnostico", CitaController, :get_citas_por_diagnostico

  end
end
