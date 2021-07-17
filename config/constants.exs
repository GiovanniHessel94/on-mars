use Mix.Config

config :on_mars, :constants,
  supported_commands: [:GE, :GD, :M],
  turn_commands: [:GE, :GD],
  move_commands: [:M],
  x_axis_upper_limit: 4,
  y_axis_upper_limit: 4
