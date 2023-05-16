defmodule CitasAppWeb.PacienteJSON do
  alias CitasApp.Pacientes.Paciente

  @doc """
  Renders a list of pacientes.
  """
  def index(%{pacientes: pacientes}) do
    %{data: for(paciente <- pacientes, do: data(paciente))}
  end

  @doc """
  Renders a single paciente.
  """
  def show(%{paciente: paciente}) do
    %{data: data(paciente)}
  end

  defp data(%Paciente{} = paciente) do

    citas = paciente.citas
    |> Enum.map(& Map.from_struct(&1))
    |> Enum.map(& Enum.reduce([:__meta__, :paciente, :paciente_id, :inserted_at, :updated_at], &1, fn key, acc -> Map.delete(acc, key) end))
    %{
      id: paciente.id,
      num_id: paciente.num_id,
      nombres: paciente.nombres,
      apellidos: paciente.apellidos,
      mail: paciente.mail,
      fecha_nac: paciente.fecha_nac,
      citas: citas
    }
  end
end
