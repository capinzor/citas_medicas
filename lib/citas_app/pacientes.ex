defmodule CitasApp.Pacientes do
  @moduledoc """
  The Pacientes context.
  """

  import Ecto.Query, warn: false
  alias CitasApp.Repo

  alias CitasApp.Pacientes.Paciente

  @doc """
  Returns the list of pacientes.

  ## Examples

      iex> list_pacientes()
      [%Paciente{}, ...]

  """
  def list_pacientes do
    Repo.all(Paciente) |> Repo.preload(:citas)
  end

  @doc """
  Gets a single paciente.

  Raises `Ecto.NoResultsError` if the Paciente does not exist.

  ## Examples

      iex> get_paciente!(123)
      %Paciente{}

      iex> get_paciente!(456)
      ** (Ecto.NoResultsError)

  """
  def get_paciente!(id), do: Repo.get!(Paciente, id) |> Repo.preload(:citas)

  @doc """
  Creates a paciente.

  ## Examples

      iex> create_paciente(%{field: value})
      {:ok, %Paciente{}}

      iex> create_paciente(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_paciente(attrs \\ %{}) do
    %Paciente{}
    |> Paciente.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a paciente.

  ## Examples

      iex> update_paciente(paciente, %{field: new_value})
      {:ok, %Paciente{}}

      iex> update_paciente(paciente, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_paciente(%Paciente{} = paciente, attrs) do
    paciente
    |> Paciente.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a paciente.

  ## Examples

      iex> delete_paciente(paciente)
      {:ok, %Paciente{}}

      iex> delete_paciente(paciente)
      {:error, %Ecto.Changeset{}}

  """
  def delete_paciente(%Paciente{} = paciente) do
    Repo.delete(paciente)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking paciente changes.

  ## Examples

      iex> change_paciente(paciente)
      %Ecto.Changeset{data: %Paciente{}}

  """
  def change_paciente(%Paciente{} = paciente, attrs \\ %{}) do
    Paciente.changeset(paciente, attrs)
  end
end
