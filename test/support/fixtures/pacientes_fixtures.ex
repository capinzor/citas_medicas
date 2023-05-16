defmodule CitasApp.PacientesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CitasApp.Pacientes` context.
  """

  @doc """
  Generate a paciente.
  """
  def paciente_fixture(attrs \\ %{}) do
    {:ok, paciente} =
      attrs
      |> Enum.into(%{
        apellidos: "some apellidos",
        fecha_nac: ~D[2023-05-14],
        mail: "some mail",
        nombres: "some nombres",
        num_id: "some num_id"
      })
      |> CitasApp.Pacientes.create_paciente()

    paciente
  end
end
