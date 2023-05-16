defmodule CitasApp.CitasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CitasApp.Citas` context.
  """

  @doc """
  Generate a cita.
  """
  def cita_fixture(attrs \\ %{}) do
    {:ok, cita} =
      attrs
      |> Enum.into(%{
        diagnostico: "some diagnostico",
        fecha: ~D[2023-05-14],
        medicamentos: "some medicamentos",
        sintomas: "some sintomas"
      })
      |> CitasApp.Citas.create_cita()

    cita
  end
end
