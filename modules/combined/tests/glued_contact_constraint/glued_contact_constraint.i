[Mesh]
  type = FileMesh
  file = simplest_contact.e
  displacements = 'disp_x disp_y'
[]

[Variables]
  # Variables
  [./disp_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_y]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  # AuxVariables
  [./penetration]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[SolidMechanics]
  [./solid]
    disp_x = disp_x
    disp_y = disp_y
  [../]
[]

[AuxBCs]
  [./penetration]
    type = PenetrationAux
    variable = penetration
    boundary = 2
    paired_boundary = 3
  [../]
[]

[Constraints]
  [./contact_x]
    type = GluedContactConstraint
    variable = disp_x
    component = 0
    slave = 2
    master = 3
    disp_x = disp_x
    disp_y = disp_y
    penalty = 1e6
    nodal_area = penetration
    boundary = 2
  [../]
  [./contact_y]
    type = GluedContactConstraint
    variable = disp_y
    component = 1
    slave = 2
    master = 3
    disp_x = disp_x
    disp_y = disp_y
    penalty = 1e6
    nodal_area = penetration
    boundary = 3
  [../]
[]

[BCs]
  # BCs
  [./left_x]
    type = DirichletBC
    variable = disp_x
    boundary = 1
    value = 0.0
  [../]
  [./left_y]
    type = DirichletBC
    variable = disp_y
    boundary = 1
    value = 0.0
  [../]
  [./right_x]
    type = PresetBC
    variable = disp_x
    boundary = 4
    value = -0.0001
  [../]
  [./right_y]
    type = DirichletBC
    variable = disp_y
    boundary = 4
    value = 0.0
  [../]
[]

[Materials]
  # Materials
  [./stiffStuff1]
    type = LinearIsotropicMaterial
    block = 1
    disp_x = disp_x
    disp_y = disp_y
    youngs_modulus = 1e6
    poissons_ratio = 0.3
  [../]
[]

[Executioner]
  type = Transient
  solve_type = PJFNK
  petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart'
  petsc_options_value = 'hypre    boomeramg      101'
  line_search = none
  nl_abs_tol = 1e-8
  l_max_its = 100
  nl_max_its = 10
  dt = 1.0
  num_steps = 1
[]

[Outputs]
  file_base = out
  output_initial = true
  [./exodus]
    type = Exodus
    elemental_as_nodal = true
  [../]
  [./console]
    type = Console
    perf_log = true
    linear_residuals = true
  [../]
[]
