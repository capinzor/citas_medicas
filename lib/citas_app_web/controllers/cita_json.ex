defmodule CitasAppWeb.CitaJSON do
  alias CitasApp.Citas.Cita

  @doc """
  Renders a list of citas.
  """
  def index(%{citas: citas}) do
    %{data: for(cita <- citas, do: data(cita))}
  end

  @doc """
  Renders a single cita.
  """
  def show(%{cita: cita}) do
    %{data: data(cita)}
  end

  defp data(%Cita{} = cita) do
    paciente = [cita.paciente]
    |> Enum.map(& Map.from_struct(&1))
    |> Enum.map(& Enum.reduce([:__meta__, :citas, :inserted_at, :updated_at], &1, fn key, acc -> Map.delete(acc, key) end))
    |> List.first
    %{
      id: cita.id,
      fecha: cita.fecha,
      sintomas: cita.sintomas,
      diagnostico: cita.diagnostico,
      medicamentos: cita.medicamentos,
      paciente: paciente
    }
  end
end
