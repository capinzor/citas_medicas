defmodule CitasApp.Citas do
  @moduledoc """
  The Citas context.
  """

  import Ecto.Query, warn: false
  alias CitasApp.Repo

  alias CitasApp.Citas.Cita

  @doc """
  Returns the list of citas.

  ## Examples

      iex> list_citas()
      [%Cita{}, ...]

  """
  def list_citas do
    Repo.all(Cita) |> Repo.preload(:pacientes)
  end

  @doc """
  Gets a single cita.

  Raises `Ecto.NoResultsError` if the Cita does not exist.

  ## Examples

      iex> get_cita!(123)
      %Cita{}

      iex> get_cita!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cita!(id), do: Repo.get!(Cita, id) |> Repo.preload(:pacientes)

  @doc """
  Creates a cita.

  ## Examples

      iex> create_cita(%{field: value})
      {:ok, %Cita{}}

      iex> create_cita(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def get_citas_por_diagnostico!(diagnostico) do
    query = from(c in Cita, where: c.diagnostico == ^diagnostico)
    Repo.all(query) |> Repo.preload(:paciente)
  end


  def create_cita(attrs \\ %{}) do
    %Cita{}
    |> Cita.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cita.

  ## Examples

      iex> update_cita(cita, %{field: new_value})
      {:ok, %Cita{}}

      iex> update_cita(cita, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cita(%Cita{} = cita, attrs) do
    cita
    |> Cita.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cita.

  ## Examples

      iex> delete_cita(cita)
      {:ok, %Cita{}}

      iex> delete_cita(cita)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cita(%Cita{} = cita) do
    Repo.delete(cita)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cita changes.

  ## Examples

      iex> change_cita(cita)
      %Ecto.Changeset{data: %Cita{}}

  """
  def change_cita(%Cita{} = cita, attrs \\ %{}) do
    Cita.changeset(cita, attrs)
  end
end
