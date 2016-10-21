defmodule Classnames do
  @doc false
  defmacro __using__(_opts) do
    quote do
      import Classnames, only: [classnames: 1]
    end
  end

  @doc """
  Generates a class name string from a list.

  iex> Classnames.classnames([:one])
  "one"

  iex> Classnames.classnames(["one"])
  "one"

  iex> Classnames.classnames([:one, :two])
  "one two"

  iex> Classnames.classnames([active: 1 == 1])
  "active"

  iex> Classnames.classnames([active: 1 == 2])
  ""

  iex> Classnames.classnames([:one, :two, active: 1 == 1])
  "one two active"

  iex> Classnames.classnames([:one, :two, active: 1 == 2])
  "one two"

  iex> Classnames.classnames([{:active, 1 == 1}])
  "active"

  iex> Classnames.classnames([{:active, 1 == 2}])
  ""

  iex> Classnames.classnames([:one, {:active, 1 == 1}])
  "one active"

  iex> Classnames.classnames([:one, {:active, 1 == 2}])
  "one"

  iex> Classnames.classnames(:one)
  ** (FunctionClauseError) no function clause matching in Classnames.classnames/1
  """
  def classnames(opts) when is_list(opts) do
    opts
    |> Enum.map(&normalize_classname/1)
    |> Enum.reject(&(is_nil(&1)))
    |> Enum.uniq
    |> Enum.join(" ")
  end

  defp normalize_classname({classname, condition}) do
    if condition, do: normalize_classname(classname)
  end
  defp normalize_classname(nil), do: nil
  defp normalize_classname(false), do: nil
  defp normalize_classname(classname) when is_atom(classname) do
    Atom.to_string(classname)
  end
  defp normalize_classname(classname), do: classname
end
