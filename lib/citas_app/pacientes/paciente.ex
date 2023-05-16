defmodule CitasApp.Pacientes.Paciente do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pacientes" do
    field :apellidos, :string
    field :fecha_nac, :date
    field :mail, :string
    field :nombres, :string
    field :num_id, :string
    has_many :citas, CitasApp.Citas.Cita
    timestamps()
  end

  @doc false
  def changeset(paciente, attrs) do
    paciente
    |> cast(attrs, [:num_id, :nombres, :apellidos, :mail, :fecha_nac])
    |> validate_required([:num_id, :nombres, :apellidos, :mail, :fecha_nac])
    |> validate_length(:num_id, max: 10, message: "Identification id must have up to 10 digits")
    |> unique_constraint(:num_id, message: "Paciente already exists with this num id")
  end
end
