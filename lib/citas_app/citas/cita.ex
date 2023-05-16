defmodule CitasApp.Citas.Cita do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "citas" do
    field :diagnostico, :string
    field :fecha, :date
    field :medicamentos, :string
    field :sintomas, :string
    #field :paciente_id, :binary_id
    belongs_to :paciente, CitasApp.Pacientes.Paciente
    timestamps()
  end

  @doc false
  def changeset(cita, attrs) do
    cita
    |> cast(attrs, [:fecha, :sintomas, :diagnostico, :medicamentos, :paciente_id])
    |> validate_required([:fecha, :sintomas, :diagnostico, :medicamentos])
  end
end
