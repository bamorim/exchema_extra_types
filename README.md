# ExchemaExtra

This is a Umbrella Project where we explore some extra types that we use at Stone.
We use this project to share some types between our projects and some of them may be moved
to more specific libraries over time.

For every type here, we'll include the type itself and optionally (and if the modules are available)
the coercions and StreamData generators.

We also provide some extra predicates that you can include to refine some of these types.

## Types

The types we provide are

- General *Techy* types
  - `UUID` (with some variations for version, format and etc)
  - `Email`
  - `JWT`
- Types that are specific for Brazil
  - Address Types:
    - `CEP` (Brazillian Zip Code)
    - `State` (Brazillian states)
  - Doc Number Types:
    - `CPF`
    - `CNPJ`

## Installation

```elixir
def deps do
  [
    {:exchema_extra, github: "bamorim/exchema_extra_types"}
  ]
end
```