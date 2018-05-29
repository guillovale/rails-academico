# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160921165318) do

  create_table "academico_alumno", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "CIInfPer",     limit: 20, null: false, comment: "clave foranea cedula del estudiante"
    t.string "NombColegio",  limit: 60,              comment: "nombre del colegio del cual proviene el estudiante o aspirante"
    t.string "Bachillerato", limit: 45,              comment: "tipo de bachillerato del estudiante"
    t.string "Procedencia",  limit: 45,              comment: "La procedencia del estudiante tipo de colegio del cual proviene"
    t.date   "FechGrado",                            comment: "fecha de graduación en secuandaria del estudiante"
    t.float  "CalifGrado",   limit: 24,              comment: "calificación de grado"
    t.string "provincia",    limit: 30,              comment: "provincia en el cual consta el colegio en el que se graduo el estudiante"
    t.string "Especialidad", limit: 60,              comment: "Especialidad en la que se graduo el estudiante"
    t.index ["CIInfPer"], name: "CIInfPer", using: :btree
  end

  create_table "academico_docente", primary_key: "ad_id", id: :float, limit: 53, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ciinfper",              limit: 20,  null: false, comment: "clave foranea, numero de cedula del docente"
    t.string   "ad_titulo",             limit: 150,              comment: "titulo universitario profesional del docente"
    t.string   "ad_institucion",        limit: 100,              comment: "Institución de educación superior en la que obtubo el titulo profesional o de especialización"
    t.string   "ad_pais",               limit: 30,               comment: "pasi donde esta la institución de educación superior donde obtuvo el titulo el docente"
    t.date     "ad_fecha_titulo",                   null: false
    t.string   "ad_regconesup",         limit: 60,               comment: "numero de registro del titulo del docente en la institución de registro de titulos"
    t.date     "fecha_reg_conesup",                 null: false, comment: "fecha de registro en el sistema academico"
    t.string   "sub_area_conocimiento", limit: 60,  null: false
    t.integer  "ad_estado",             limit: 2,                comment: "indicador de vigencia del titulo"
    t.datetime "ultima_actualizacion",              null: false
    t.integer  "nv_id",                 limit: 2,   null: false
    t.string   "ad_archivo",            limit: 100, null: false
    t.string   "cod_ies",               limit: 4,   null: false
    t.index ["ciinfper"], name: "FK_informaiconpersonal_d_academico_docente", using: :btree
    t.index ["nv_id"], name: "fk_academico_docente_nivel1_idx", using: :btree
  end

  create_table "acadotrotitulo", primary_key: "aot_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "tabla para almacenar los datos de titulos obtenidos en otras" do |t|
    t.string  "CIInfPer",        limit: 20,  null: false, comment: "cedula del estudiante"
    t.string  "institucion",     limit: 100, null: false, comment: "nombre de la universidad en donde reliazo los estudios"
    t.string  "Pais",            limit: 60,  null: false, comment: "pais donde obtuvo el titulo"
    t.string  "Nivel",           limit: 30,  null: false, comment: "nivel del tutulo tercero cuarto otros"
    t.string  "Titulo",          limit: 100, null: false, comment: "nombre del titulo que obtuvo"
    t.integer "Anio_graduacion", limit: 2,   null: false, comment: "año de graduacion del estudiante"
    t.index ["CIInfPer"], name: "fk_acadotrotitulo_informacionpersonal1_idx", using: :btree
  end

  create_table "acaduea", primary_key: "ac_id", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "ac_FechIngreso",                                           comment: "fecha de ingreso a la institución"
    t.string   "ac_FormaIngreso",               limit: 45,                 comment: "forma de ingreso a la institución, examen de ingreso, propedeutico, otros"
    t.string   "CIInfper",                      limit: 20,    null: false, comment: "clave foranea cedula del estudiante"
    t.string   "idcarr",                        limit: 8,     null: false
    t.date     "ac_fecha_resol_egre",                         null: false, comment: "fecha de resolucion de egresamiento"
    t.string   "ac_num_resol_egre",             limit: 20,    null: false
    t.integer  "ac_duracion",                   limit: 2,     null: false
    t.datetime "ac_ingreso_resol_egresamiento",               null: false
    t.boolean  "ac_perfil",                                   null: false
    t.date     "ac_fecha_resol_aprob_perfil",                 null: false
    t.string   "ac_resolucion_aprob_perfil",    limit: 20,    null: false
    t.datetime "ac_ingreso_resol_aprob_perfil",               null: false
    t.boolean  "ac_proyecto",                                 null: false
    t.date     "ac_fecha_resol_aprob_proyecto",               null: false
    t.date     "ac_fecha_inicio_trabajo_campo",               null: false
    t.string   "ac_resolucion_aprob_proyecto",  limit: 20,    null: false, comment: "numero de resolucion"
    t.text     "ac_proyecto_titulacion",        limit: 65535, null: false, comment: "nombre del proyecto de titulacion"
    t.string   "ac_director_proyecto",          limit: 60,    null: false
    t.string   "ac_observ_perfil_proyecto",     limit: 200,   null: false, comment: "observaciones para el campo perfil o proyecto"
    t.date     "ac_fecha_defensa",                            null: false
    t.time     "ac_hora_defensa",                             null: false
    t.date     "ac_fecha_resol_defensa",                      null: false
    t.string   "ac_num_resol_defensa",          limit: 20,    null: false
    t.string   "ac_tribunal_defensa",           limit: 200,   null: false
    t.datetime "ac_ingreso_resol_defensa",                    null: false
    t.date     "ac_fecha_incorporacion",                      null: false
    t.text     "ac_observaciones",              limit: 65535, null: false
    t.boolean  "ac_egresado",                                 null: false, comment: "indica si es egresado"
    t.boolean  "ac_titulado",                                 null: false, comment: "indica si es titulado"
    t.integer  "ac_estado",                     limit: 2,     null: false, comment: "indica si es Egresado (E) Graduado(G)  Estudiante (E)"
    t.integer  "ac_estado_habilitado",          limit: 1,     null: false
    t.integer  "verificado",                                  null: false
    t.index ["CIInfper"], name: "CIInfper", using: :btree
  end

  create_table "actividad_empresa", primary_key: "ae_id", id: :string, limit: 2, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ae_nombre", limit: 60
  end

  create_table "actividad_nodocencia", primary_key: "id_dist", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "CIInfPer",         limit: 20,  null: false
    t.integer "idPer",                        null: false
    t.integer "id_actdist",       limit: 2,   null: false
    t.string  "idcarr",           limit: 6,   null: false
    t.string  "actividad_dist",   limit: 200, null: false
    t.integer "total_horas_dist",             null: false
    t.index ["CIInfPer"], name: "fk_actividad_nodocencia_informacionpersonal_d1_idx", using: :btree
    t.index ["id_actdist"], name: "fk_actividad_nodocencia_tipo_actividad_distributivo1", using: :btree
  end

  create_table "agenda_academica", primary_key: "idaccp", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "CIInfPer",            limit: 20,  null: false, comment: "clave foranea, numero de cedula del docente"
    t.integer  "idper",                                        comment: "identificador del periodo lectivo en el cual se registra la actividad"
    t.string   "idCarr",              limit: 6,   null: false, comment: "identificador de la carrera a la cual pertenece la actividad"
    t.string   "objetivo",            limit: 200,              comment: "objetivo alcanzado con la actividad"
    t.integer  "id_actividad",        limit: 2,   null: false
    t.string   "actividad",           limit: 200,              comment: "tipo de actividad: direccion de tesis, investigación, otros"
    t.string   "avance",              limit: 200,              comment: "comentario sobre avance de la actividad"
    t.date     "fecha_actividad",                              comment: "fecha en la que se realizo la actividad"
    t.date     "fecha_actividad_fin",             null: false
    t.time     "hora_inicio",                                  comment: "hora de inicio de la actividad"
    t.time     "hora_fin",                                     comment: "hora final de la actividad"
    t.boolean  "todo_el_dia",                     null: false, comment: "idnica si el evento es todo el día"
    t.string   "localidad",           limit: 200, null: false, comment: "indica la localidad donde se realiza el evento"
    t.string   "recordatorio",        limit: 8,   null: false, comment: "determina el tiempo para el recordatorio del evento"
    t.datetime "fecha_registro",                               comment: "fecha en la que se registra la actividad, para uso del sistema"
    t.string   "ip_pcacceso",         limit: 20,               comment: "direccion ip del pc del cual se registra la actividad"
    t.string   "nomb_pcacceso",       limit: 30,               comment: "nombre del pc del cual se registra la actividad"
    t.string   "usu_agenda",          limit: 12,  null: false, comment: "usuario que creo el evento"
    t.boolean  "estado",                          null: false, comment: "indica si el evento o actividad se ha cumplido"
    t.string   "evidencia",           limit: 100, null: false, comment: "documento digital de la evidencia del evento"
    t.datetime "fecha_ultim_modif",               null: false
    t.string   "usu_aprobacion",      limit: 20,  null: false
    t.datetime "fecha_aprobacion",                null: false
    t.bigint   "id_dist",                         null: false
    t.index ["CIInfPer"], name: "fk_agenda_academica_informacionpersonal_d1_idx", using: :btree
    t.index ["id_actividad"], name: "fk_agenda_academica_tipo_actividad_distributivo1_idx", using: :btree
  end

  create_table "alumno_practica", primary_key: "ap_id", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "idPer",                                       null: false
    t.string   "idoficio",                        limit: 20
    t.string   "CIInfPer",                        limit: 10,  null: false
    t.string   "idcarr",                          limit: 10
    t.date     "fecha_reg"
    t.string   "nombemp",                         limit: 100
    t.string   "nomb_gerente",                    limit: 100
    t.string   "cargo_gerente",                   limit: 100
    t.date     "fechaI",                                      null: false
    t.date     "fechaF",                                      null: false
    t.boolean  "realiza_practica_preprofesional",             null: false
    t.boolean  "realiza_pasantia",                            null: false
    t.float    "horas_practica_pasantia",         limit: 24,  null: false
    t.datetime "ultima_actualizacion",                        null: false
    t.integer  "periodolectivo_idper",                        null: false
    t.string   "informacionpersonal_CIInfPer",    limit: 10,  null: false
    t.index ["idPer"], name: "fk_alumno_practica_periodolectivo1", using: :btree
  end

  create_table "ambiente", primary_key: "id_amb", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "inst_cod",        limit: 12,  null: false, comment: "codigo de la institucion a la cual pertenece la localidad"
    t.string  "cod_amb",         limit: 10
    t.string  "nomb_amb",        limit: 60
    t.integer "amb_id",          limit: 2
    t.integer "capacidad_amb",   limit: 2
    t.integer "cap_optima",      limit: 2
    t.string  "observacion_amb", limit: 100
    t.integer "status_amb",      limit: 1
  end

  create_table "ambiente_recurso", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id_recur",     limit: 2, null: false
    t.integer "cantidad_rec", limit: 2, null: false
    t.integer "id_amb",       limit: 2, null: false
    t.index ["id_amb"], name: "fk_ambiente_recurso_ambiente1", using: :btree
    t.index ["id_recur"], name: "fk_ambiente_recurso_recurso1", using: :btree
  end

  create_table "archivo_acta_calif", primary_key: "id_aac", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "dpa_id"
    t.string   "tipo_acta", limit: 20
    t.string   "archivo",   limit: 100
    t.datetime "fecha_reg"
    t.string   "usu_reg",   limit: 20
    t.boolean  "estado"
  end

  create_table "asignatura", primary_key: "IdAsig", id: :string, limit: 10, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "NombAsig",   limit: 70
    t.string  "ColorAsig",  limit: 10
    t.boolean "StatusAsig"
  end

  create_table "asignatura_wvd", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "IdAsig",     limit: 10, null: false
    t.string  "NombAsig",   limit: 70
    t.string  "ColorAsig",  limit: 10
    t.boolean "StatusAsig"
  end

  create_table "asistencia_alumno", primary_key: "id_asist", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ciinfper",         limit: 20
    t.date     "fecha_asal"
    t.time     "hora_asal"
    t.integer  "idPer"
    t.bigint   "idnaa",                          null: false,                                            unsigned: true
    t.string   "observacion_asal", limit: 60
    t.integer  "numsesion_asal",   limit: 2
    t.boolean  "presente"
    t.boolean  "ausente"
    t.boolean  "atraso"
    t.boolean  "justificada"
    t.datetime "fecha_creacion",                 null: false, comment: "fecha de creacion del registro"
    t.datetime "fecha_modif",                    null: false, comment: "fecha de ultima modificacion"
    t.text     "observacion",      limit: 65535, null: false, comment: "observaciones al registro"
    t.bigint   "id_plasig",                      null: false
    t.index ["ciinfper"], name: "asistencia_alumno_ibfk_2", using: :btree
    t.index ["idnaa"], name: "fk_asistencia_alumno_notasalumnoasignatura1", using: :btree
  end

  create_table "base_datos_publicacion", primary_key: "bdp_id", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "bdp_nombre", limit: 100
    t.boolean "bdp_estado"
  end

  create_table "bitacora", primary_key: "bt_id", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "bt_usuario",     limit: 12
    t.datetime "bt_fechahora"
    t.string   "bt_accion",      limit: 100
    t.string   "bt_ippc",        limit: 30
    t.string   "bt_observacion", limit: 600
  end

  create_table "bitacora_slrap_sl_noregistrado", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "sl_id",    null: false
    t.bigint "slrap_id", null: false
  end

  create_table "califfinalalumnoasig", primary_key: "evalfinal_id", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ciinfper",          limit: 20
    t.integer  "idPer"
    t.bigint   "idnaa",                                                   null: false,                                                                                  unsigned: true
    t.date     "cfaa_fecha"
    t.string   "cfaa_desceval",     limit: 60
    t.decimal  "cfaa_calificacion",               precision: 5, scale: 1
    t.datetime "cfaa_fechareg",                                           null: false, comment: "fecha de creacion del registro"
    t.string   "cfaa_usureg",       limit: 13
    t.datetime "cfaa_fechamodif",                                         null: false, comment: "fecha ultima modificacion"
    t.string   "cfaa_usumodif",     limit: 10
    t.text     "cfaa_observacion",  limit: 65535,                         null: false, comment: "observaciones al registro"
    t.integer  "cfaa_estado",       limit: 1,                                          comment: "permite habilitar o deshabilitar la modificacion de una calificacion"
  end

  create_table "califfrecuentealumnoasig", primary_key: "evalfrec_id", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ciinfper",            limit: 20
    t.integer  "idPer"
    t.bigint   "idnaa",                                                     null: false,                                                                                  unsigned: true
    t.date     "cfaa_fecha"
    t.string   "cfaa_desceval",       limit: 60
    t.decimal  "cfaa_calificacion",                 precision: 5, scale: 1
    t.datetime "cfaa_fechareg",                                             null: false, comment: "fecha de creacion del registro"
    t.string   "cfaa_usureg",         limit: 13
    t.datetime "cfaa_fechamodif",                                           null: false, comment: "fecha ultima modificacion"
    t.string   "cfaa_usumodif",       limit: 10
    t.text     "cfaa_observacion",    limit: 65535,                         null: false, comment: "observaciones al registro"
    t.string   "cfaa_usu_habilita",   limit: 10,                            null: false
    t.datetime "cfaa_fecha_habilita",                                       null: false
    t.integer  "cfaa_estado",         limit: 1,                                          comment: "permite habilitar o deshabilitar la modificacion de una calificacion"
    t.index ["idnaa"], name: "fk_califfrecuentealumnoasig_notasalumnoasignatura1", using: :btree
  end

  create_table "califparcialalumnoasig", primary_key: "evalpar_id", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ciinfper",            limit: 10
    t.integer  "idPer"
    t.bigint   "idnaa",                                                     null: false,                                                                                  unsigned: true
    t.date     "cpaa_fecha"
    t.string   "cpaa_desceval",       limit: 60
    t.decimal  "cpaa_calificacion",                 precision: 5, scale: 1
    t.datetime "cpaa_fechareg",                                             null: false, comment: "fecha de creacion del registro"
    t.string   "cpaa_usureg",         limit: 13
    t.datetime "cpaa_fechamodif",                                           null: false, comment: "fecha ultima modificacion"
    t.string   "cpaa_usumodif",       limit: 10
    t.text     "cpaa_observacion",    limit: 65535,                         null: false, comment: "observaciones al registro"
    t.string   "cpaa_usu_habilita",   limit: 10,                            null: false
    t.datetime "cpaa_fecha_habilita",                                       null: false
    t.integer  "cpaa_estado",         limit: 1,                                          comment: "permite habilitar o deshabilitar la modificacion de una calificacion"
    t.index ["idnaa"], name: "fk_califparcialalumnoasig_notasalumnoasignatura1", using: :btree
  end

  create_table "canton", primary_key: "id_canton", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "codigo",  limit: 4
    t.string "detalle", limit: 100
  end

  create_table "capacitacion_docente", primary_key: "ccdp_id", id: :bigint, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "ciinfper",         limit: 20,  null: false
    t.string  "tcap_id",          limit: 2
    t.string  "ccdp_nombre",      limit: 100
    t.string  "ccdp_institucion", limit: 100
    t.integer "ccdp_num_horas"
    t.date    "ccdp_fecha_ini"
    t.date    "ccdp_fecha_fin"
    t.string  "ccdp_archivo",     limit: 100, null: false
    t.index ["tcap_id"], name: "tcap_id", using: :btree
  end

  create_table "cargo_dependencia", primary_key: "cdp_id", id: :string, limit: 4, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "cdp_nombre", limit: 60
    t.boolean "cdp_status"
  end

  create_table "carr_sbaunesco", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "sau_id", limit: 2
    t.string  "idCarr", limit: 6
  end

  create_table "carrera", primary_key: "idCarr", id: :string, limit: 6, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "NombCarr",         limit: 45
    t.string  "nivelCarr",        limit: 20
    t.integer "StatusCarr",       limit: 2,  null: false
    t.string  "codCarr_senescyt", limit: 8,  null: false, comment: "codigo oferta senescyt "
    t.integer "mod_id",                      null: false
    t.string  "sau_id",           limit: 4,  null: false
    t.integer "id_tc",                       null: false
    t.string  "inst_cod",         limit: 12, null: false
    t.string  "idcarr_utelvt",    limit: 10, null: false
    t.integer "idsede"
    t.integer "idfacultad"
    t.index ["id_tc"], name: "fk_carrera_titulo1_idx", using: :btree
    t.index ["mod_id"], name: "fk_carrera_modalidad1_idx", using: :btree
    t.index ["sau_id"], name: "fk_carrera_subarea_unesco1_idx", using: :btree
  end

  create_table "carrera_centros", primary_key: "cc_id", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "idcarr",         limit: 6
    t.string  "idcentro",       limit: 6
    t.integer "cc_num_niveles", limit: 2
    t.string  "mv_id",          limit: 9
    t.boolean "cc_estado"
    t.string  "cc_reg_usu",     limit: 20, null: false
  end

  create_table "carrera_modalidad", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "mod_id", limit: 2
    t.string  "idCarr", limit: 6
  end

  create_table "carrera_resolucion", primary_key: "cr_id", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "idCarr",       limit: 6
    t.string "cr_documento", limit: 100
    t.index ["idCarr"], name: "idCarr", using: :btree
  end

  create_table "carrera_titulo", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "idCarr", limit: 6
    t.integer "id_tc",  limit: 1
  end

  create_table "categoria_colegio", primary_key: "cc_id", id: :string, limit: 2, collation: "latin1_swedish_ci", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cc_nombre", limit: 16, collation: "latin1_swedish_ci"
    t.string "codigo",    limit: 1
  end

  create_table "cic_dpa_docente", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "cic_id", null: false, unsigned: true
    t.bigint  "dpa_id", null: false
    t.index ["cic_id"], name: "fk_cic_dpa_docente_control_ingreso_calificacion1_idx", using: :btree
    t.index ["dpa_id"], name: "fk_cic_dpa_docente_docenteperasig1_idx", using: :btree
  end

  create_table "contractual_docente", primary_key: "id_contdoc", id: :float, limit: 53, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "CIInfper",                  limit: 20,  null: false
    t.date     "fechaingreso"
    t.date     "fechatermino",                          null: false
    t.string   "categoria",                 limit: 3
    t.string   "cargo",                     limit: 100
    t.string   "relaciontrabajo",           limit: 4
    t.string   "dedicacion",                limit: 2,   null: false
    t.integer  "horas_dedicacion",                      null: false
    t.string   "unidad_academica",          limit: 60
    t.string   "num_contrato_nombramiento", limit: 100, null: false
    t.float    "remuneracion",              limit: 24,  null: false
    t.boolean  "ingresaxconcurso",                      null: false, comment: "identifica si el docente ingreso por concurso"
    t.integer  "tipo"
    t.integer  "status",                    limit: 2
    t.datetime "ultima_modificacion",                   null: false
    t.string   "archivo",                   limit: 100, null: false, comment: "archivo del contrato del docente"
    t.string   "tdc_id",                    limit: 2,   null: false
    t.index ["CIInfper"], name: "fk_contractual_docente_informacionpersonal_d1", using: :btree
  end

  create_table "control_evidencia", primary_key: "ce_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "idper"
    t.date     "ce_fecha_ini"
    t.date     "ce_fecha_fin"
    t.string   "ce_grupo",          limit: 4
    t.string   "ce_descripcion",    limit: 20, null: false,                                 comment: "descripcion del control de mes"
    t.boolean  "ce_estado"
    t.datetime "ce_fecha_creacion"
    t.string   "ce_usu_crea",       limit: 20,              collation: "latin1_swedish_ci"
  end

  create_table "control_ingreso_calificacion", primary_key: "cic_id", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date    "cic_fechaini"
    t.date    "cic_fechafin"
    t.string  "cic_tipo",     limit: 3
    t.integer "cic_status"
  end

  create_table "control_periodo_matricula", primary_key: "id_cpm", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "idPer",                       null: false
    t.date    "cmp_fechainicio"
    t.date    "cmp_fechafin"
    t.string  "cmp_tipo",        limit: 16
    t.integer "cmp_status"
    t.string  "cmp_tipo2",       limit: 16
    t.string  "cmp_observacion", limit: 200, null: false
    t.index ["idPer"], name: "fk_control_periodo_matricula_periodolectivo1_idx", using: :btree
  end

  create_table "coordinador_carrera", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ciinfper",        limit: 20
    t.string "apellnomb_coord", limit: 100
    t.string "idcarr",          limit: 10
  end

  create_table "cupoxcarrera", primary_key: "cc_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "idcarr",              limit: 6
    t.integer "idper",                         null: false
    t.integer "idanio"
    t.integer "idsemestre"
    t.integer "cc_cupo"
    t.integer "cc_num_paralelos",              null: false
    t.integer "cc_estudiantesxaula",           null: false
    t.boolean "cc_estado"
    t.index ["cc_estudiantesxaula"], name: "fk_cupoxcarrera_carrera1", using: :btree
    t.index ["cc_num_paralelos"], name: "fk_cupoxcarrera_periodolectivo1", using: :btree
  end

  create_table "cursa_estudios", primary_key: "ec_id", id: :float, limit: 53, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ciinfper",                 limit: 20,  null: false
    t.string   "ec_numdoc",                limit: 20,  null: false
    t.string   "ec_titulo",                limit: 150
    t.string   "ec_institucion",           limit: 100
    t.string   "ec_pais",                  limit: 30
    t.date     "ec_fecha_inicia",                      null: false
    t.date     "ec_fecha_termina",                     null: false
    t.string   "ec_sub_area_conocimiento", limit: 4,   null: false
    t.integer  "ec_estado",                limit: 2
    t.datetime "ultima_actualizacion",                 null: false
    t.integer  "nv_id",                    limit: 2,   null: false
    t.string   "ec_archivo",               limit: 100, null: false
    t.string   "ec_inst_financia",         limit: 100, null: false
    t.index ["ciinfper"], name: "ciinfper", using: :btree
  end

  create_table "dia_feriado", primary_key: "id_df", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date    "fecha_df"
    t.string  "tipo",           limit: 2,   null: false
    t.string  "observacion_df", limit: 200
    t.integer "idper",                      null: false
    t.time    "hora_inicio",                null: false
    t.time    "hora_fin",                   null: false
    t.integer "status",         limit: 1
    t.index ["idper"], name: "fk_dia_feriado_periodolectivo1_idx", using: :btree
  end

  create_table "dias_laborables", primary_key: "dl_id", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "idPer",                 null: false
    t.date    "dl_fecha"
    t.integer "dl_dia",     limit: 2
    t.string  "dl_nom_dia", limit: 11, null: false
    t.string  "dl_av_dia",  limit: 3
    t.integer "dl_status",  limit: 1
    t.index ["idPer"], name: "fk_dias_laborables_periodolectivo1_idx", using: :btree
  end

  create_table "discapacidad", primary_key: "dsp_id", id: :string, limit: 1, collation: "latin1_swedish_ci", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "dsp_nombre", limit: 20, collation: "latin1_swedish_ci"
  end

  create_table "doc_personal_docente", primary_key: "dpd_id", id: :string, limit: 60, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ciinfper",           limit: 20,  null: false
    t.string   "td_id",              limit: 2
    t.string   "doc_digital",        limit: 100, null: false
    t.boolean  "estado"
    t.string   "usu_registra",       limit: 10,  null: false, comment: "usuario que registra el documento"
    t.datetime "fecha_registro",                 null: false
    t.string   "usu_modif",          limit: 10,  null: false
    t.datetime "fecha_ultima_modif",             null: false
  end

  create_table "doc_personal_estudiante", primary_key: "dpe_id", id: :string, limit: 60, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ciinfper",           limit: 20,  null: false
    t.string   "td_id",              limit: 2
    t.string   "doc_digital",        limit: 100, null: false
    t.boolean  "estado"
    t.string   "usu_registra",       limit: 10,  null: false, comment: "usuario que registra el documento"
    t.datetime "fecha_registro",                 null: false
    t.string   "usu_modif",          limit: 10,  null: false
    t.datetime "fecha_ultima_modif",             null: false
  end

  create_table "docente_aspirante_phd", primary_key: "dap_id", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "CIInfPer",           limit: 20,                 null: false
    t.string  "dap_lugar_estudios", limit: 100,                null: false
    t.string  "dap_institucion",    limit: 100,                null: false
    t.string  "dap_tipo",           limit: 100,                null: false
    t.boolean "dap_estado",                     default: true, null: false
    t.index ["CIInfPer"], name: "fk_docente_aspirante_phd_informacionpersonal_d1", using: :btree
  end

  create_table "docente_cargoautoridad", primary_key: "dca_id", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "CIInfPer",                    limit: 20,              null: false
    t.string  "cargo_autoridad",             limit: 2
    t.string  "descripcion_cargo_autoridad", limit: 100,             null: false
    t.string  "idcarr",                      limit: 6
    t.string  "num_doc_cargo_autoridad",     limit: 20
    t.date    "fecha_ini_carg_aut"
    t.date    "fecha_fin_crag_aut"
    t.integer "estado",                      limit: 1
    t.integer "status_eval",                 limit: 1,   default: 0, null: false, comment: "sirve para saber que carrera tienen asignaturas dentro para evaluacion"
    t.string  "archivo_dca",                 limit: 100,             null: false
    t.index ["CIInfPer"], name: "fk_docente_cargoautoridad_informacionpersonal_d1_idx", using: :btree
    t.index ["idcarr"], name: "idcarrera", using: :btree
  end

  create_table "docente_cargoautoridad2", primary_key: "dca_id", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "CIInfPer",                    limit: 20,  null: false
    t.string  "cargo_autoridad",             limit: 100, null: false
    t.string  "descripcion_cargo_autoridad", limit: 100
    t.string  "num_doc_cargo_autoridad",     limit: 20
    t.string  "tipo_cargo",                  limit: 15,  null: false
    t.date    "fecha_ini_carg_aut"
    t.date    "fecha_fin_carg_aut"
    t.boolean "estado_dca"
    t.string  "archivo_dca",                 limit: 100, null: false
    t.index ["CIInfPer"], name: "fk_docente_cargoautoridad2_informacionpersonal_d1", using: :btree
  end

  create_table "docente_carrera", primary_key: "iddc", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "idper"
    t.string  "ciinfper", limit: 20
    t.string  "idcarr",   limit: 6,  null: false
  end

  create_table "docentecontacadperlec", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint  "id_dcapl",                null: false
    t.string  "CIInfPer",     limit: 20, null: false
    t.float   "id_contdoc",   limit: 53, null: false
    t.float   "ad_id",        limit: 53, null: false
    t.integer "idper",                   null: false
    t.boolean "estado_dcapl",            null: false
    t.string  "inst_cod",     limit: 12, null: false
    t.index ["CIInfPer"], name: "fk_docentecontacadperlec_informacionpersonal_d1_idx", using: :btree
    t.index ["estado_dcapl"], name: "fk_docentecontacadperlec_academico_docente1_idx", using: :btree
    t.index ["id_contdoc"], name: "fk_docentecontacadperlec_contractual_docente1_idx", using: :btree
    t.index ["idper"], name: "fk_docentecontacadperlec_periodolectivo1_idx", using: :btree
  end

  create_table "docenteperasig", primary_key: "dpa_id", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "CIInfPer",          limit: 20,                 null: false
    t.integer "idPer",                                        null: false
    t.string  "idAsig",            limit: 10
    t.string  "idCarr",            limit: 6
    t.integer "idAnio"
    t.integer "idSemestre"
    t.string  "idParalelo",        limit: 2
    t.integer "status",            limit: 2
    t.float   "idMc",              limit: 24,                 null: false
    t.string  "tipo_orgmalla",     limit: 2,                  null: false, comment: "tipo organizacion malla"
    t.boolean "id_actdist",                                   null: false, comment: "identifica el tipo de actividad del distributivo"
    t.float   "id_contdoc",        limit: 53,                 null: false
    t.boolean "transf_asistencia",                            null: false
    t.boolean "transf_frecuente",                             null: false
    t.boolean "transf_parcial",                               null: false
    t.boolean "transf_final",                                 null: false
    t.boolean "arrastre",                     default: false, null: false
    t.boolean "extra",                        default: false, null: false
    t.index ["CIInfPer"], name: "fk_docenteperasig_informacionpersonal_d1_idx", using: :btree
    t.index ["idPer"], name: "idPer", using: :btree
  end

  create_table "documentos_acaduea", primary_key: "docau_id", id: :bigint, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Permita almacenar los archivos vinculados al proceso de titu" do |t|
    t.bigint   "ac_id",                         null: false
    t.string   "docau_nombarchivo", limit: 100, null: false
    t.string   "docau_tipo",        limit: 60,  null: false, comment: "identifica si se trata de documento de egresamiento, titulacion u otros"
    t.datetime "docau_fechareg",                null: false, comment: "fecha de registro del archivo"
    t.integer  "docau_estado",      limit: 1,   null: false
    t.index ["ac_id"], name: "fk_documentos_acaduea_acaduea1", using: :btree
  end

  create_table "documentos_alumno", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "CIInfPer",          limit: 20, null: false
    t.integer "idPer"
    t.integer "cp_cedula",         limit: 1
    t.integer "cedula_militar",    limit: 1
    t.integer "papeleta_votacion", limit: 1
    t.integer "solicitud_ingreso", limit: 1
    t.string  "cp_actagrado",      limit: 3
    t.integer "estado",            limit: 1
    t.index ["CIInfPer"], name: "fk_informacionpersonal_docalumno1", using: :btree
  end

  create_table "documentos_distributivo", primary_key: "id_ds", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "idper",                  null: false
    t.string  "tipodoc_ds",  limit: 50, null: false
    t.date    "fechadoc_ds",            null: false
    t.integer "numdoc_ds",              null: false
    t.string  "docdig_ds",   limit: 30, null: false, comment: "documento digitalizado"
    t.boolean "estado_ds",              null: false
  end

  create_table "eje_formacion", primary_key: "idef", id: :string, limit: 3, default: "", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "nombef", limit: 30
  end

  create_table "equivalencia", primary_key: ["idequivalencia", "asignatura", "equivalencia"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "idequivalencia",             null: false
    t.string   "asignatura",     limit: 10,  null: false
    t.string   "equivalencia",   limit: 10,  null: false
    t.datetime "fecha"
    t.string   "usuario",        limit: 100
  end

  create_table "estado_civil", primary_key: "ec_id", id: :string, limit: 2, collation: "latin1_swedish_ci", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ec_nombre", limit: 12, collation: "latin1_swedish_ci"
  end

  create_table "estudiante_organizacionmalla", primary_key: "id_orgmalla", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "CIInfPer",             limit: 20, null: false
    t.string  "tipo_orgmalla",        limit: 2,  null: false
    t.boolean "estado_orgmalla"
    t.integer "anio_mallacurricular",            null: false
    t.index ["CIInfPer"], name: "fk_estudiante_organizacionmalla_informacionpersonal1_idx", using: :btree
    t.index ["tipo_orgmalla"], name: "fk_estudiante_organizacionmalla_organizacion_malla1_idx", using: :btree
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.text     "description", limit: 65535
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "facultad", primary_key: "idfacultad", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "facultad", limit: 45
  end

  create_table "grupo_asignatura", primary_key: "grp_id", id: :string, limit: 3, default: "", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "grp_nombre", limit: 60
    t.boolean "grp_estado"
  end

  create_table "grupo_sanguineo", primary_key: "gs_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "gs_nombre", limit: 3, collation: "latin1_swedish_ci"
  end

  create_table "grupoasig_docente", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "grp_id", limit: 3
    t.bigint  "dpa_id"
    t.integer "idper"
    t.index ["dpa_id"], name: "dpa_id", using: :btree
    t.index ["grp_id"], name: "grp_id", using: :btree
  end

  create_table "horario_clase", primary_key: "hc_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.time    "hc_horainicio"
    t.time    "hc_horafin"
    t.integer "hc_periodo",    limit: 1,  null: false, comment: "indica el periodo de clase"
    t.string  "hc_seccion",    limit: 20, null: false, comment: "indica la seccion, si esta matutino, vespertino nocturna"
    t.integer "hc_status",     limit: 1
  end

  create_table "horario_examen", primary_key: "he_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "idper"
    t.float    "dpa_id",            limit: 53
    t.date     "he_fecha"
    t.string   "he_usu_registra",   limit: 20
    t.datetime "he_fecha_registra"
    t.string   "id_localidad",      limit: 20
  end

  create_table "horclase_asig_docente_amb", primary_key: "hcad_id", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "idper",                    null: false
    t.integer "hcad_diasemana", limit: 1
    t.bigint  "dpa_id",                   null: false
    t.integer "id_amb",         limit: 2, null: false
    t.integer "hc_id",          limit: 2, null: false
    t.string  "idcarr",         limit: 6, null: false
    t.integer "idanio",         limit: 1, null: false
    t.integer "idsemestre",     limit: 1, null: false
    t.string  "idparalelo",     limit: 2, null: false
    t.index ["dpa_id"], name: "fk_horclase_asig_docente_amb_docenteperasig1_idx", using: :btree
    t.index ["hc_id"], name: "fk_horclase_asig_docente_amb_horario_clase1", using: :btree
    t.index ["id_amb"], name: "fk_horclase_asig_docente_amb_ambiente1", using: :btree
    t.index ["idper"], name: "fk_horclase_asig_docente_amb_periodolectivo1", using: :btree
  end

  create_table "huella_dactilar", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Huellas digitales de los docentes, estudiantes o administrat" do |t|
    t.string  "CIInfPer",         limit: 20,         null: false, comment: "Cedula de identificaciÃ³n del docente, estudioante o administrativo"
    t.string  "hd_tipo",          limit: 14,         null: false, comment: "indica el tipo de usuario docente, estudiante o administrativo"
    t.integer "hd_posicion",      limit: 1,          null: false, comment: "posicion del dedo el cual se captura la huella digital"
    t.binary  "hd_imagen_huella", limit: 4294967295, null: false, comment: "caracteres de la imagen de la huella digital en formato WSQ"
    t.string  "codigo_dactilar",  limit: 12,         null: false, comment: "codigo dactilar de la cedula de identidad"
  end

  create_table "informacionpersonal", primary_key: "CIInfPer", id: :string, limit: 20, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "cedula_pasaporte",        limit: 13,         null: false, comment: "numero de identificacion del estudiante"
    t.string   "TipoDocInfPer",           limit: 1
    t.string   "ApellInfPer",             limit: 45
    t.string   "ApellMatInfPer",          limit: 45
    t.string   "NombInfPer",              limit: 45
    t.string   "NacionalidadPer",         limit: 45
    t.integer  "EtniaPer",                limit: 2
    t.date     "FechNacimPer"
    t.string   "LugarNacimientoPer",      limit: 120
    t.string   "GeneroPer",               limit: 1
    t.string   "EstadoCivilPer",          limit: 1
    t.string   "CiudadPer",               limit: 45
    t.string   "DirecDomicilioPer",       limit: 100
    t.string   "Telf1InfPer",             limit: 12
    t.string   "CelularInfPer",           limit: 12
    t.string   "TipoInfPer",              limit: 2
    t.integer  "statusper"
    t.string   "mailPer",                 limit: 60
    t.string   "mailInst",                limit: 60
    t.integer  "GrupoSanguineo",          limit: 2
    t.string   "tipo_discapacidad",       limit: 1,          null: false, comment: "tipo de discapacidad"
    t.string   "carnet_conadis",          limit: 2,          null: false, comment: "indica si tiene carnet del conadis"
    t.string   "num_carnet_conadis",      limit: 20,         null: false, comment: "numero de carnet del conadis si lo tiene"
    t.integer  "porcentaje_discapacidad", limit: 2,          null: false, comment: "procentaje de discapacidad que tiene"
    t.binary   "fotografia",              limit: 4294967295
    t.string   "codigo_dactilar",         limit: 100,        null: false, comment: "codigo dactilar para tomarlo como password de ingreso"
    t.integer  "hd_posicion",             limit: 1,          null: false
    t.binary   "huella_dactilar",         limit: 4294967295, null: false, comment: "captura informacion de la huella dactilar del estudiante"
    t.datetime "ultima_actualizacion",                       null: false
    t.string   "codigo_verificacion",     limit: 50,         null: false, comment: "codigo de verificacion para becas"
    t.integer  "provincia_id"
  end

  create_table "informacionpersonal_d", primary_key: "CIInfPer", id: :string, limit: 20, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "cedula_pasaporte",        limit: 13,         null: false, comment: "numero de identifcacion del docente"
    t.string   "TipoDocInfPer",           limit: 1
    t.string   "ApellInfPer",             limit: 45
    t.string   "ApellMatInfPer",          limit: 45
    t.string   "NombInfPer",              limit: 45
    t.string   "NacionalidadPer",         limit: 45
    t.integer  "EtniaPer",                limit: 2,          null: false, comment: "etnia del docente"
    t.date     "FechNacimPer"
    t.string   "LugarNacimientoPer",      limit: 45
    t.string   "GeneroPer",               limit: 1
    t.string   "EstadoCivilPer",          limit: 1
    t.string   "CiudadPer",               limit: 45
    t.string   "DirecDomicilioPer",       limit: 45
    t.string   "Telf1InfPer",             limit: 12
    t.string   "Telf2InfPer",             limit: 12
    t.string   "CelularInfPer",           limit: 12
    t.string   "TipoInfPer",              limit: 2
    t.string   "StatusPer",               limit: 1
    t.string   "mailPer",                 limit: 60
    t.string   "mailInst",                limit: 60
    t.integer  "GrupoSanguineo",          limit: 2
    t.string   "tipo_discapacidad",       limit: 1,          null: false
    t.string   "carnet_conadis",          limit: 2,          null: false
    t.string   "num_carnet_conadis",      limit: 20,         null: false
    t.integer  "porcentaje_discapacidad", limit: 2,          null: false
    t.binary   "fotografia",              limit: 4294967295
    t.string   "codigo_dactilar",         limit: 15,         null: false, comment: "codigo dactilar de la cedula"
    t.integer  "hd_posicion",             limit: 1,          null: false
    t.binary   "huella_dactilar",         limit: 4294967295, null: false, comment: "captura informacion de la huella dactilar del docente"
    t.datetime "ultima_actualizacion",                       null: false
    t.string   "LoginUsu",                limit: 20,         null: false, comment: "login de usuario para el docente"
    t.string   "ClaveUsu",                limit: 100,        null: false, comment: "contraseña de acceso al sistema del docente"
    t.boolean  "StatusUsu",                                  null: false, comment: "Indica el estado de habilitado o bloqueado"
    t.string   "idcarr",                  limit: 10,         null: false, comment: "identificador de carrera para el docente"
    t.boolean  "usa_biometrico",                             null: false, comment: "indica si el docnete tendra acceso mediante el biometrico"
    t.datetime "fecha_reg",                                  null: false, comment: "indica la fecha de registro y crecaion del usuario"
    t.datetime "fecha_ultimo_acceso",                        null: false, comment: "indica la fecha de ultimo acceso del usuario"
    t.string   "usu_registra",            limit: 20,         null: false, comment: "usuario que creo el registro"
    t.string   "usu_modifica",            limit: 20,         null: false
    t.datetime "fecha_ultima_modif",                         null: false
  end

  create_table "inscripcion", primary_key: "Numero_Inscp", id: :string, limit: 20, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date    "fecha_inscp"
    t.date    "fecha_leginsc"
    t.string  "CIInfPer",          limit: 20,  null: false
    t.float   "arancel",           limit: 24
    t.string  "idcarr",            limit: 6,   null: false
    t.integer "status",            limit: 2
    t.integer "idper",                         null: false
    t.string  "observacion_inscp", limit: 200
    t.integer "estado",                        null: false, comment: "permite indicar si el estudante aprobo el examen o el curso de admision"
    t.string  "usu_registra",      limit: 30,  null: false
    t.string  "tipo_inscp",        limit: 4,   null: false
    t.index ["idcarr"], name: "fk_inscripcion_carrera1_idx", using: :btree
    t.index ["idper"], name: "fk_inscripcion_periodolectivo1_idx", using: :btree
  end

  create_table "inst_carr", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "inst_cod", limit: 12, null: false
    t.string "idCarr",   limit: 6,  null: false
    t.index ["idCarr"], name: "fk_inst_carr_carrera1", using: :btree
    t.index ["inst_cod"], name: "fk_inst_carr_institucion1", using: :btree
  end

  create_table "inst_educ_sup", primary_key: "cod_ies", id: :string, limit: 4, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "nomb_ies", limit: 160,                null: false
    t.string  "cod_pais", limit: 2,                  null: false
    t.boolean "estado",               default: true, null: false
  end

  create_table "institucion", primary_key: "inst_cod", id: :string, limit: 12, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "inst_cod_senescyt",  limit: 8,                  null: false
    t.string  "inst_provincia",     limit: 30
    t.string  "inst_canton",        limit: 30
    t.string  "inst_parroquia",     limit: 30
    t.string  "inst_direccion",     limit: 100
    t.string  "inst_telefono1",     limit: 12
    t.string  "inst_telefono2",     limit: 12
    t.string  "inst_fax",           limit: 12
    t.string  "inst_email",         limit: 60
    t.string  "inst_web",           limit: 30
    t.string  "inst_tipo",          limit: 2,                  null: false, comment: "indica si es matriz centro de apoyo, otros"
    t.string  "inst_nombre",        limit: 60,                 null: false, comment: "nombre de la institucion"
    t.string  "inst_nombre_campus", limit: 100,                null: false, comment: "nombre del campus universitario"
    t.string  "inst_logo",          limit: 100,                null: false, comment: "logotipo de la institucion"
    t.string  "inst_rector",        limit: 100,                null: false, comment: "rector actual de la universidad"
    t.boolean "inst_estado",                    default: true, null: false
    t.index ["inst_tipo"], name: "fk_institucion_tipo_institucion1_idx", using: :btree
  end

  create_table "laboral_alumno", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "CIInfPer",         limit: 20,  null: false
    t.string "nomb_empresa",     limit: 60
    t.string "direcc_empresa",   limit: 100
    t.string "telef_empresa",    limit: 10
    t.string "TipoEmpresa",      limit: 2,   null: false, comment: "tipo de empresa en la que labora el estudiante"
    t.string "ActividadEmpresa", limit: 2,   null: false, comment: "actividad que realiza la empresa en la que labora el estudiante"
    t.string "OtraActividad",    limit: 100, null: false, comment: "opcionl si el estudiante se en cuentra reazlaiando otra actividad de las que no esta en lista"
    t.string "Cargo",            limit: 100, null: false, comment: "cargo que desempeña el estudiuante en su trabajo"
    t.string "ProvinciaEmpresa", limit: 30,  null: false, comment: "provincia donde seencuentra ubicada la empresa"
    t.string "CantonProvincia",  limit: 30,  null: false, comment: "canton donde se encuentra ubicada la empresa"
    t.string "extTelfEmpresa",   limit: 8,   null: false, comment: "extension telefonica de la empresa"
    t.index ["CIInfPer"], name: "fk_laboral_alumno_informacionpersonal1_idx", using: :btree
  end

  create_table "malla_curricular", primary_key: "idMc", id: :float, limit: 24, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "idCarr",            limit: 6,  null: false
    t.string   "idAsig",            limit: 10, null: false
    t.integer  "idAnio"
    t.integer  "idSemestre"
    t.string   "idef",              limit: 3,  null: false, comment: "identificador del eje de formación"
    t.integer  "num_creditos",                 null: false, comment: "nmero de créditos de la asignatura"
    t.integer  "horas_semanales",              null: false
    t.string   "caracter",          limit: 20, null: false
    t.integer  "status"
    t.string   "org_mallacurr",     limit: 2,  null: false, comment: "organizacion de la malla curricular"
    t.string   "anio_habilitacion", limit: 4,  null: false, comment: "identifica el año desde que esta habilitada la malla curricular"
    t.string   "codigo",            limit: 30, null: false
    t.datetime "fecha_registro",               null: false
    t.string   "usu_registra",      limit: 10, null: false
    t.datetime "fecha_modif"
    t.string   "usu_modif",         limit: 10, null: false
    t.boolean  "imp",                          null: false
    t.index ["idAsig"], name: "malla_curricular_ibfk_2", using: :btree
    t.index ["idCarr"], name: "malla_curricular_ibfk_1", using: :btree
    t.index ["idef"], name: "fk_malla_curricular_eje_formacion1_idx", using: :btree
  end

  create_table "malla_curricular_wvd", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.float   "idMc",              limit: 24, default: 0.0, null: false
    t.string  "idCarr",            limit: 6,                null: false
    t.string  "idAsig",            limit: 10,               null: false
    t.integer "idAnio"
    t.integer "idSemestre"
    t.string  "idef",              limit: 3,                null: false, comment: "identificador del eje de formación"
    t.integer "num_creditos",                               null: false, comment: "nmero de créditos de la asignatura"
    t.integer "horas_semanales",                            null: false
    t.string  "caracter",          limit: 20,               null: false
    t.integer "status"
    t.string  "org_mallacurr",     limit: 2,                null: false, comment: "organizacion de la malla curricular"
    t.string  "anio_habilitacion", limit: 4,                null: false, comment: "identifica el año desde que esta habilitada la malla curricular"
  end

  create_table "malla_estudiante", primary_key: "id_malla", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string   "cedula",            limit: 20, null: false
    t.string   "carrera",           limit: 10, null: false
    t.string   "anio_habilitacion", limit: 10, null: false
    t.datetime "fecha"
  end

  create_table "malla_vigencia", primary_key: "mv_id", id: :string, limit: 9, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "idcarr",      limit: 6
    t.string  "mv_anio",     limit: 4
    t.boolean "mv_aprobada"
    t.boolean "mv_estado"
  end

  create_table "mallacurr_coprerrequisitos", primary_key: "mcprcorr_id", id: :bigint, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.float    "idMc",           limit: 24
    t.float    "idMc_cprreq",    limit: 24
    t.string   "tipo",           limit: 2
    t.boolean  "estado",                    null: false
    t.datetime "fecha_registro",            null: false
    t.string   "usu_registra",   limit: 10, null: false, comment: "usuario que creo el registro"
    t.datetime "fecha_modif"
    t.string   "usu_modif",      limit: 10, null: false, comment: "usuario que modifica el registro"
  end

  create_table "mallacurricularperiodo", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float   "idMc",            limit: 24, null: false
    t.integer "idPer"
    t.integer "horas_semanales",            null: false
    t.integer "horas_total",                null: false
    t.integer "num_creditos",               null: false
    t.string  "idef",            limit: 3,  null: false
    t.string  "caracter",        limit: 20, null: false
    t.boolean "compensar_horas",            null: false
    t.index ["idMc"], name: "idMc", using: :btree
    t.index ["idPer"], name: "idPer", using: :btree
  end

  create_table "matricula", primary_key: "idMatricula", id: :string, limit: 20, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "idMatricula_anual",  limit: 20,                           comment: "identificador de matricula anual que correspnde al total de ciclos en el año y se mostrara en las matriculas independientes y libro de matriculas"
    t.integer  "idPer",                                      null: false
    t.string   "CIInfPer",           limit: 10,              null: false
    t.string   "idCarr",             limit: 6
    t.integer  "idanio",             limit: 1
    t.integer  "idsemestre",         limit: 1
    t.date     "FechaMatricula"
    t.string   "idParalelo",         limit: 3
    t.string   "idMatricula_ant",    limit: 20
    t.string   "tipoMatricula",      limit: 1
    t.string   "statusMatricula",    limit: 10
    t.boolean  "anulada",                                                 comment: "INDICA SI LA MATRICULA HA SIDO ANULADA"
    t.string   "observMatricula",    limit: 200,                          comment: "observacion de la matricula si se presenta alguna"
    t.integer  "promocion",          limit: 1,   default: 1,              comment: "indica si el estudiante cn la matricula fue promovido 1=promovido 0=no promovido"
    t.string   "Usu_registra",       limit: 20,                           comment: "usuario que crea el registro"
    t.datetime "Fecha_crea",                                              comment: "fecha que se crea el registro"
    t.string   "Usu_modifica",       limit: 20,                           comment: "usuario que modifica el registro"
    t.datetime "Fecha_ultima_modif",                                      comment: "Fecha de ultima modificación del registro"
    t.string   "archivo_aprobado",   limit: 100
    t.string   "archivo_negado",     limit: 100
    t.string   "archivo_anulado",    limit: 100
    t.index ["CIInfPer"], name: "CIInfPer", using: :btree
    t.index ["idCarr"], name: "idCarr", using: :btree
    t.index ["idPer"], name: "idPer", using: :btree
  end

  create_table "menu_nav", primary_key: "id_opcion", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id_modulo"
    t.string  "item_id",        limit: 60
    t.string  "item_tit",       limit: 60
    t.string  "item_icono",     limit: 60
    t.string  "item_tipo",      limit: 10
    t.boolean "leaf",                       default: true
    t.boolean "expandido",                  default: true
    t.integer "posicion_orden", limit: 2,                  null: false
    t.string  "descripcion",    limit: 200,                null: false
    t.boolean "status",                     default: true, null: false
  end

  create_table "menu_perfil", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id_opcion",                           null: false
    t.string  "id_perfil", limit: 10,                null: false
    t.boolean "status",               default: true, null: false
    t.index ["id_opcion"], name: "fk_menu_perfil_menu_nav1", using: :btree
    t.index ["id_perfil"], name: "fk_menu_perfil_perfil1", using: :btree
  end

  create_table "modalidad", primary_key: "mod_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "mod_nomb", limit: 30
  end

  create_table "nivel", primary_key: "nv_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "nv_numnivel",    limit: 1,  null: false
    t.string  "nv_descripcion", limit: 20
    t.string  "nv_formacion",   limit: 60, null: false
  end

  create_table "nivel_carrera", primary_key: "nvc_id", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "nvc_numnivel",  limit: 2
    t.string  "nvc_formacion", limit: 40
  end

  create_table "notas", primary_key: "idnaa", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "CIInfPer",                 limit: 20,                          null: false, comment: "Nro de cedula del estudiante"
    t.string   "idAsig",                   limit: 10,                                       comment: "Codigo de la asignatura"
    t.integer  "idPer",                                                                     comment: "Codigo del periodo lectivo"
    t.decimal  "CalifFinal",                           precision: 5, scale: 1,              comment: "Calificacion \r\n\r\nfinal promediada"
    t.integer  "asistencia",               limit: 2,                                        comment: "porcentaje de asistencia del estudiante en la asignatura"
    t.integer  "StatusCalif",              limit: 2,                                        comment: "estado de la calificacion"
    t.string   "idMatricula",              limit: 20,                                       comment: "coidgo de matricula del estudiante en el periodo lectivo"
    t.integer  "VRepite",                  limit: 2,                                        comment: "Veces que repite la asignatura"
    t.string   "observacion",              limit: 200,                         null: false
    t.boolean  "op1",                                                          null: false, comment: "indica si el estudiante dio examen supletorio"
    t.boolean  "op2",                                                          null: false, comment: "si el estudante tomo curso remediar"
    t.boolean  "op3",                                                          null: false, comment: "indica si el estudiante dio examen suficiencia"
    t.boolean  "pierde_x_asistencia",                                          null: false, comment: "indica si el estudiante pierde por asistencia"
    t.boolean  "repite",                                                       null: false, comment: "indica si el estudiante repite asignatura"
    t.boolean  "retirado",                                                     null: false, comment: "si se retira de la asignatura o desertor"
    t.boolean  "excluidaxrepitencia",                                          null: false, comment: "se excluye si el estudiante pierde y toma nuevamente las asignatura"
    t.boolean  "excluidaxreingreso",                                           null: false, comment: "se excluye la asignatura si ele studiante reingresa a la carrera"
    t.boolean  "excluidaxresolucion",                                          null: false
    t.boolean  "convalidacion",                                                null: false, comment: "indica si la asignatura es convalidacion"
    t.boolean  "aprobada",                                                     null: false, comment: "indica si la asignatura esta aprobada"
    t.boolean  "anulada",                                                      null: false, comment: "indentifica si una asignatura ha sidoa anuladada"
    t.boolean  "arrastre",                                                     null: false
    t.datetime "registro_asistencia",                                          null: false, comment: "registra la fecha de transferencia de la asistencia"
    t.string   "usu_registro_asistencia",  limit: 20,                          null: false, comment: "usuario que registro la asistencia"
    t.datetime "registro",                                                     null: false, comment: "fecha de registro de la calificacion"
    t.datetime "ultima_modificacion",                                          null: false
    t.string   "usu_pregistro",            limit: 20,                          null: false, comment: "usuario que realizo el primer registro de la calificacion"
    t.string   "usu_umodif_registro",      limit: 20,                          null: false, comment: "usuario que realiza la ultima modificacion del registro"
    t.string   "archivo",                  limit: 100,                         null: false
    t.float    "idMc",                     limit: 24,                          null: false
    t.string   "porcentaje_convalidacion", limit: 5,                           null: false
    t.boolean  "exam_final_atrasado",                                          null: false
    t.boolean  "exam_supl_atrasado",                                           null: false
    t.string   "observacion_efa",          limit: 60,                          null: false
    t.string   "observacion_espa",         limit: 60,                          null: false
    t.string   "usu_habilita_efa",         limit: 60,                          null: false
    t.string   "usu_habilita_espa",        limit: 60,                          null: false
    t.bigint   "dpa_id",                                                       null: false
    t.index ["CIInfPer"], name: "CIInfPer", using: :btree
    t.index ["idAsig"], name: "notasalumnoasignatura_ibfk_4", using: :btree
    t.index ["idMatricula"], name: "idMatricula", using: :btree
    t.index ["idPer"], name: "idPer", using: :btree
  end

  create_table "notasalumnoasignatura", primary_key: "idnaa", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "CIInfPer",                 limit: 20,                          null: false, comment: "Nro de cedula del estudiante"
    t.string   "idAsig",                   limit: 10,                                       comment: "Codigo de la asignatura"
    t.integer  "idPer",                                                                     comment: "Codigo del periodo lectivo"
    t.decimal  "CAC1",                                 precision: 5, scale: 1,              comment: "Primera calificación \r\n\r\nacumulativa"
    t.decimal  "CAC2",                                 precision: 5, scale: 1,              comment: "Segunda calififcación \r\n\r\nacumulativa"
    t.decimal  "CAC3",                                 precision: 5, scale: 1,              comment: "Tercera calififcación \r\n\r\nacumulativa"
    t.decimal  "TCAC",                                 precision: 5, scale: 1,              comment: "Promedio calificaciones \r\n\r\nacumulativas"
    t.decimal  "CEF",                                  precision: 5, scale: 1,              comment: "Calificación evaluación \r\n\r\nFinal"
    t.decimal  "CSP",                                  precision: 5, scale: 1,              comment: "Calificación supletorio"
    t.decimal  "CCR",                                  precision: 5, scale: 1,              comment: "calificacion curso \r\n\r\nintensivo"
    t.decimal  "CSP2",                                 precision: 5, scale: 1,              comment: "Calificación examen \r\n\r\nsuficiencia"
    t.decimal  "CalifFinal",                           precision: 5, scale: 1,              comment: "Calificacion \r\n\r\nfinal promediada"
    t.integer  "asistencia",                                                                comment: "porcentaje de asistencia del estudiante en la asignatura"
    t.integer  "StatusCalif",              limit: 2,                                        comment: "estado de la calificacion"
    t.string   "idMatricula",              limit: 20,                                       comment: "coidgo de matricula del estudiante en el periodo lectivo"
    t.integer  "VRepite",                  limit: 2,                                        comment: "Veces que repite la asignatura"
    t.string   "observacion",              limit: 200
    t.boolean  "op1",                                                                       comment: "indica si el estudiante dio examen supletorio"
    t.boolean  "op2",                                                                       comment: "si el estudante tomo curso remediar"
    t.boolean  "op3",                                                                       comment: "indica si el estudiante dio examen suficiencia"
    t.boolean  "pierde_x_asistencia",                                                       comment: "indica si el estudiante pierde por asistencia"
    t.boolean  "repite",                                                                    comment: "indica si el estudiante repite asignatura"
    t.boolean  "retirado",                                                                  comment: "si se retira de la asignatura o desertor"
    t.boolean  "excluidaxrepitencia",                                                       comment: "se excluye si el estudiante pierde y toma nuevamente las asignatura"
    t.boolean  "excluidaxreingreso",                                                        comment: "se excluye la asignatura si ele studiante reingresa a la carrera"
    t.boolean  "excluidaxresolucion"
    t.boolean  "convalidacion",                                                             comment: "indica si la asignatura es convalidacion"
    t.boolean  "aprobada",                                                                  comment: "indica si la asignatura esta aprobada"
    t.boolean  "anulada",                                                                   comment: "indentifica si una asignatura ha sidoa anuladada"
    t.boolean  "arrastre"
    t.datetime "registro_asistencia",                                                       comment: "registra la fecha de transferencia de la asistencia"
    t.string   "usu_registro_asistencia",  limit: 20,                                       comment: "usuario que registro la asistencia"
    t.datetime "registro",                                                                  comment: "fecha de registro de la calificacion"
    t.datetime "ultima_modificacion"
    t.string   "usu_pregistro",            limit: 20,                                       comment: "usuario que realizo el primer registro de la calificacion"
    t.string   "usu_umodif_registro",      limit: 20,                                       comment: "usuario que realiza la ultima modificacion del registro"
    t.string   "archivo",                  limit: 100
    t.float    "idMc",                     limit: 24
    t.string   "institucion_proviene",     limit: 100
    t.string   "porcentaje_convalidacion", limit: 5
    t.boolean  "exam_final_atrasado"
    t.boolean  "exam_supl_atrasado"
    t.string   "observacion_efa",          limit: 60
    t.string   "observacion_espa",         limit: 60
    t.string   "usu_habilita_efa",         limit: 60
    t.string   "usu_habilita_espa",        limit: 60
    t.bigint   "dpa_id"
    t.index ["CIInfPer"], name: "CIInfPer", using: :btree
    t.index ["idAsig"], name: "notasalumnoasignatura_ibfk_4", using: :btree
    t.index ["idMatricula"], name: "idMatricula", using: :btree
    t.index ["idPer"], name: "idPer", using: :btree
    t.index ["institucion_proviene"], name: "fk_notasalumnoasignatura_matricula1", using: :btree
  end

  create_table "opciones_calif", primary_key: "opc_id", id: :string, limit: 3, collation: "latin1_swedish_ci", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "opc_nombre", limit: 25,                             collation: "latin1_swedish_ci"
    t.string  "opc_grupo",  limit: 16,                             collation: "latin1_swedish_ci"
    t.boolean "opc_estado",            default: true, null: false
  end

  create_table "organizacion_malla", primary_key: "tipo_orgmalla", id: :string, limit: 2, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "desc_orgmalla", limit: 45
  end

  create_table "pais", primary_key: "cod_pais", id: :string, limit: 2, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "nomb_pais",         limit: 60,                 null: false
    t.string  "nacionalidad_pais", limit: 60,                 null: false
    t.boolean "estado",                       default: false, null: false
    t.string  "codigo",            limit: 3
  end

  create_table "paramcalif_perlec", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "idPer",      null: false
    t.integer "id_pmcalif", null: false
    t.index ["idPer"], name: "fk_paramcalif_perlec_periodolectivo1_idx", using: :btree
    t.index ["id_pmcalif"], name: "fk_paramcalif_perlec_parametros_calificacion1_idx", using: :btree
  end

  create_table "parametros_calificacion", primary_key: "id_pmcalif", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "nota_min_exonera"
    t.integer "nota_min_supletorio"
    t.integer "calif_min_aprob_sp"
    t.integer "calif_min_aprob_ccr"
    t.integer "calif_min_aprob_sp2"
    t.integer "min_asist",                                  comment: "asistencia minima que el estudiante necesita para aprobar el curso y habilitarse a examenes finales"
    t.boolean "permitir_decimal"
    t.integer "n_decimal"
    t.integer "eac1_max"
    t.integer "eac2_max"
    t.integer "eac3_max"
    t.integer "efn_max"
    t.integer "esp_max"
    t.integer "eccr_max"
    t.integer "esp2_max"
    t.integer "asist_max"
    t.integer "eac1_min"
    t.integer "eac2_min"
    t.integer "eac3_min"
    t.integer "efn_min"
    t.integer "esp_min"
    t.integer "eccr_min"
    t.integer "esp2_min"
    t.integer "asist_min",                                  comment: "parametro de validacion de asistencia"
    t.integer "num_max_matricula",   limit: 2, null: false
    t.integer "base_conversion"
    t.integer "division",            limit: 1
    t.integer "estado",              limit: 1
  end

  create_table "perfil", primary_key: "idperfil", id: :string, limit: 10, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "nombperfil", limit: 30
    t.integer "nivel"
    t.integer "status"
  end

  create_table "periodolectivo", primary_key: "idper", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date    "fechinicioperlec"
    t.date    "fechfinalperlec"
    t.string  "DescPerLec",          limit: 10
    t.integer "StatusPerLec"
    t.integer "cicloPerLec"
    t.date    "inicioClases",                   null: false
    t.date    "finClases",                      null: false
    t.date    "examfinal_ini",                  null: false
    t.date    "examfinal_fin",                  null: false
    t.date    "examsupletorio_ini",             null: false
    t.date    "examsupletorio_fin",             null: false
    t.date    "ci_fechinicio",                  null: false
    t.date    "ci_fechfin",                     null: false
    t.date    "examsuficiencia_ini",            null: false
    t.date    "examsuficiencia_fin",            null: false
    t.string  "org_mallacurr",       limit: 2,  null: false, comment: "indica el tipo de organizacion de la malla curricular si es anual semestra u otro"
    t.string  "periodosUnificado",   limit: 20, null: false, comment: "registra los id de periodos lectivos unificados"
    t.string  "descripcion_perlec",  limit: 30, null: false, comment: "descripcion textual del periodo lectivo"
  end

  create_table "planificacion_asignatura", primary_key: "id_plasig", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "dpa_id",                                             null: false
    t.integer  "num_unidad",           limit: 1,                     null: false
    t.string   "desc_unidad",          limit: 200
    t.string   "tema_clase",           limit: 200
    t.string   "contenido",            limit: 200,                   null: false
    t.string   "metodologia",          limit: 150
    t.date     "fecha"
    t.time     "hora_ini_planif",                                    null: false, comment: "hora inicial planificada "
    t.time     "hora_fin_planif",                                    null: false, comment: "hora final de planificacion"
    t.datetime "fecha_reg",                                          null: false, comment: "fecha de registro de la planificacion"
    t.text     "objetivo_plasig",      limit: 65535,                 null: false, comment: "objetivo de la planificación de la asignatura"
    t.date     "fecha_rcd"
    t.time     "hora_inicio"
    t.time     "hora_fin"
    t.string   "hc_periodo",           limit: 20
    t.integer  "num_periodos",         limit: 1
    t.string   "ip_pcacceso",          limit: 20
    t.string   "nomb_pcacceso",        limit: 30
    t.text     "observacion",          limit: 65535
    t.boolean  "atraso",                                             null: false, comment: "identifica si se inicio clases con atraso"
    t.integer  "status",               limit: 1
    t.bigint   "ps_id",                                              null: false
    t.date     "fecha_recp",                                         null: false
    t.time     "hora_ini_recp",                                      null: false
    t.time     "hora_fin_recp",                                      null: false
    t.string   "autorizacion_recp",    limit: 200,                   null: false
    t.boolean  "estado_asist",                                       null: false, comment: "indica si ya se ha realizado la toma de asistencia para la planificacion de clase"
    t.string   "acceso",               limit: 20,                    null: false, comment: "indica el acceso de donde se relalizo a la planificacion"
    t.integer  "id_amb",               limit: 2,                     null: false
    t.boolean  "habilita_asist",                                     null: false
    t.string   "usu_habilita_asist",   limit: 20,                    null: false
    t.datetime "fecha_habilita_asist"
    t.integer  "id_actdist",           limit: 2,                     null: false
    t.boolean  "habilita_frec",                      default: false, null: false
    t.string   "usu_habilita_frec",    limit: 30,                    null: false
    t.index ["dpa_id"], name: "fk_planificacion_asignatura_docenteperasig1_idx", using: :btree
  end

  create_table "programacion_silabo", primary_key: "ps_id", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint  "slrap_id",                               null: false
    t.date    "ps_fecha"
    t.time    "ps_hora_ini",                            null: false, comment: "hora de inicio de clases"
    t.time    "ps_hora_fin",                            null: false, comment: "hora finalizacion de clases"
    t.integer "ps_horas",            limit: 1
    t.text    "ps_tema",             limit: 65535
    t.text    "ps_contenido",        limit: 65535
    t.string  "ps_estrategia",       limit: 300
    t.text    "ps_biblio_basica",    limit: 65535
    t.text    "ps_biblio_compl",     limit: 65535
    t.text    "ps_recursos",         limit: 65535
    t.binary  "ps_archivo_practica", limit: 4294967295, null: false
    t.integer "id_amb",              limit: 2,          null: false
    t.boolean "ps_status",                              null: false
    t.index ["slrap_id"], name: "fk_programacion_silabo_sl_resul_aprendizaje1_idx", using: :btree
  end

  create_table "provincia", primary_key: "id_provincia", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "codigo",  limit: 2
    t.string "detalle", limit: 100
  end

  create_table "proyecto_vinculacion", primary_key: "id_pyvc", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "nomb_pyvc",   limit: 200
    t.string  "tipo_pyvc",   limit: 20,  null: false
    t.boolean "estado_pyvc"
  end

  create_table "proyectovinculacion_docente_carrera", primary_key: "id_pyvcd", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "CIInfPer",     limit: 10
    t.string  "idcarr",       limit: 10, null: false
    t.boolean "estado_pyvcd",            null: false
    t.integer "id_pyvc",                 null: false
    t.index ["id_pyvc"], name: "fk_ProyectoViculacion_Docente_proyecto_vinculacion1", using: :btree
  end

  create_table "proyvinc_carrera", primary_key: "id_pvcrr", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id_pyvc",           null: false
    t.string  "idcarr",  limit: 6, null: false, collation: "latin1_swedish_ci"
    t.index ["id_pyvc"], name: "fk_proyvinc_carrera_proyecto_vinculacion1", using: :btree
  end

  create_table "proyvincdocenteestudiante", primary_key: "id_pyvcde", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id_pyvcd",               null: false
    t.string  "idMatricula", limit: 20, null: false
    t.index ["idMatricula"], name: "fk_proyvincdocenteestudiante_matricula1_idx", using: :btree
    t.index ["id_pyvcd"], name: "fk_proyvincdocenteestudiante_proyectovinculacion_docente_ca_idx", using: :btree
  end

  create_table "publicacion_articulo_docente", primary_key: "pad_id", id: :float, limit: 53, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "CIInfPer",                limit: 20,  null: false
    t.string  "pad_nombre_publicacion",  limit: 200
    t.string  "pad_nombre_revista",      limit: 200
    t.date    "pad_fecha_publica",                   null: false
    t.integer "pad_anio_publica"
    t.string  "pad_participacion",       limit: 20
    t.string  "pad_estado_publicacion",  limit: 50
    t.string  "pad_revista_indexada",    limit: 3
    t.string  "pad_base_datos_indexada", limit: 50
    t.string  "pad_archivo",             limit: 100, null: false, comment: "archivo del articulo publicado"
    t.index ["CIInfPer"], name: "fk_publicacion_articulo_docente_informacionpersonal_d1", using: :btree
  end

  create_table "publicacion_libro_docente", primary_key: "pld_id", id: :float, limit: 53, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "CIInfPer",           limit: 20,  null: false
    t.string  "pld_nombre_libro",   limit: 200
    t.date    "pld_fecha_publica",              null: false
    t.integer "pld_anio_publica"
    t.string  "pld_participacion",  limit: 20
    t.string  "pld_revision_pares", limit: 3
    t.string  "pld_isbn",           limit: 20
    t.string  "pld_archivo",        limit: 100, null: false, comment: "archivo del libro publicado"
    t.index ["CIInfPer"], name: "fk_publicacion_libro_docente_informacionpersonal_d1_idx", using: :btree
  end

  create_table "recurso", primary_key: "id_recur", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "nomb_recur", limit: 30
  end

  create_table "registro_asistencia_pyvc_estudiante", primary_key: "id_rapyvce", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "fecha_rpyvce"
    t.string   "actividad_rpyvce",  limit: 200
    t.string   "lugar_rpyvce",      limit: 200
    t.integer  "horas_rpyvce",      limit: 2
    t.boolean  "aprobado_rpyvce"
    t.datetime "fecha_reg_rapyvce"
    t.bigint   "id_pyvcde",                     null: false
    t.index ["id_pyvcde"], name: "fk_registro_asistencia_pyvc_estudiante_proyvincdocenteestudia1", using: :btree
  end

  create_table "sede", primary_key: "idsede", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "sede", limit: 45
  end

  create_table "sexo", primary_key: "sx_id", id: :string, limit: 1, collation: "latin1_swedish_ci", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "sx_nombre", limit: 7, collation: "latin1_swedish_ci"
    t.string "codigo",    limit: 1
  end

  create_table "silabo", primary_key: "sl_id", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "dpa_id",                                       null: false
    t.integer  "sl_hteoricas",              limit: 1,          null: false, comment: "horas teoricas"
    t.integer  "sl_hpracticas",             limit: 1,          null: false, comment: "horas practicas"
    t.integer  "sl_hpresencial",            limit: 1,          null: false, comment: "horas presenciales"
    t.integer  "sl_heindependientes",       limit: 1,          null: false, comment: "horas de estudio independiente"
    t.date     "sl_fecha_elab",                                null: false, comment: "fecha de elaboraciÃ³n "
    t.text     "sl_presentacion_asig",      limit: 16777215,   null: false, comment: "2.1 presentacion de la asignatura"
    t.text     "sl_objetivos_generales",    limit: 16777215,   null: false, comment: "objetivos de la asignatura"
    t.text     "sl_resul_aprend_perfil",    limit: 16777215,   null: false, comment: "resultados de aprendizaje del perfil a los que contribuye la asignatura"
    t.text     "sl_caracter_investigacion", limit: 16777215,   null: false
    t.text     "sl_compromisos",            limit: 4294967295, null: false, comment: "compromisos academicos y eticos"
    t.text     "sl_curriculum_docente",     limit: 4294967295, null: false, comment: "informacion relevante del docente"
    t.text     "sl_bibliografia",           limit: 65535,      null: false
    t.boolean  "sl_estado",                                    null: false
    t.text     "prerrequisitos",            limit: 65535,      null: false, comment: "prerrequisitos de la asignatura"
    t.text     "correquisitos",             limit: 65535,      null: false, comment: "correquisitos de la asignatura"
    t.integer  "creditos",                                     null: false, comment: "creditos de la asignatura"
    t.boolean  "sl_terminado",                                 null: false, comment: "indica si el silabo esta terminado con todos su elementos"
    t.boolean  "sl_aprobado",                                  null: false
    t.datetime "sl_fecha_aprobacion",                          null: false
    t.string   "sl_usuario_aprobacion",     limit: 20,         null: false
    t.text     "sl_observacion_aprobacion", limit: 65535,      null: false
    t.index ["dpa_id"], name: "fk_silabo_docenteperasig1", using: :btree
  end

  create_table "sl_criterio_evaluacion", primary_key: "slce_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint  "slrap_id",                         null: false
    t.text    "slce_criterio_eval", limit: 65535, null: false
    t.text    "slce_instrumento",   limit: 65535, null: false
    t.text    "slce_nivel_logro",   limit: 65535, null: false
    t.integer "slce_valoracion",                  null: false
    t.index ["slrap_id"], name: "fk_sl_criterio_evaluacion_sl_resul_aprendizaje1_idx", using: :btree
  end

  create_table "sl_evaluaciones", primary_key: "ev_id", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "sl_id",                           null: false
    t.string "ev_tipo",             limit: 60
    t.string "ev_descripcion",      limit: 200
    t.string "ev_corte_evaluativo", limit: 60
    t.float  "ev_total",            limit: 24,  null: false, comment: "porcentaje que tiene la evaluacion en el silabo"
    t.index ["sl_id"], name: "fk_sl_evaluaciones_silabo1_idx", using: :btree
  end

  create_table "sl_resul_aprendizaje", primary_key: "slrap_id", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text    "slrap_result_aprendizaje", limit: 4294967295, null: false
    t.integer "slrap_orden",              limit: 1,          null: false
    t.bigint  "sl_id",                                       null: false
    t.index ["sl_id"], name: "fk_sl_resul_aprendizaje_silabo1_idx", using: :btree
  end

  create_table "solicitud_intensivo", primary_key: "id_is", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "idnaa"
    t.date     "fecha_solicitud"
    t.datetime "fecha_registro"
    t.string   "num_oficio",      limit: 20
    t.string   "observacion",     limit: 100
    t.integer  "tipo",            limit: 1
    t.integer  "estado",          limit: 1,   null: false
  end

  create_table "solicitud_suficiencia", primary_key: "id_is", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "idnaa"
    t.date     "fecha_solicitud"
    t.datetime "fecha_registro"
    t.string   "num_oficio",      limit: 20
    t.string   "observacion",     limit: 100
    t.integer  "tipo",            limit: 1
    t.integer  "estado",          limit: 1,   null: false
  end

  create_table "subarea_unesco", primary_key: "sau_id", id: :string, limit: 4, comment: "nodo hijo", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "sau_pdid",        limit: 4,   null: false, comment: "nodo padre"
    t.string "sau_descripcion", limit: 150, null: false
  end

  create_table "tbl_migration", primary_key: "version", id: :string, limit: 180, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "apply_time"
  end

  create_table "tipo_actividad_distributivo", primary_key: "id_actdist", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "nomb_actdist", limit: 80, null: false, comment: "nombre de la actividad del distributivo"
    t.boolean "estado",                  null: false, comment: "indica si la actividad esta activa o inactiva"
  end

  create_table "tipo_admision", primary_key: "tad_id", id: :string, limit: 4, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "tad_nombre", limit: 20
    t.integer "estado"
  end

  create_table "tipo_ambiente", primary_key: "amb_id", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "amb_nombre", limit: 60, null: false, comment: "nombre del ambiente"
  end

  create_table "tipo_capacitacion", primary_key: "tcap_id", id: :string, limit: 2, default: "", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "tcap_nombre", limit: 60
    t.boolean "tcap_estado"
  end

  create_table "tipo_cargo_directivo", primary_key: "tcgd_id", id: :string, limit: 2, collation: "latin1_swedish_ci", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "tcgd_nombre", limit: 60, collation: "latin1_swedish_ci"
  end

  create_table "tipo_categoria_docente", primary_key: "tcd_id", id: :string, limit: 3, collation: "latin1_swedish_ci", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "tcd_nombre", limit: 60, collation: "latin1_swedish_ci"
  end

  create_table "tipo_dedicacion", primary_key: "tdd_id", id: :string, limit: 2, collation: "latin1_swedish_ci", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "tdd_nombre", limit: 60, collation: "latin1_swedish_ci"
    t.integer "tdd_horas",  limit: 2
  end

  create_table "tipo_documento", primary_key: "td_id", id: :string, limit: 2, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "td_descripcion", limit: 60
    t.boolean "td_estado"
    t.integer "td_orden",       limit: 2,  null: false
  end

  create_table "tipo_documento_contrato", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "tdc_id",     limit: 3,   null: false
    t.string "tdc_nombre", limit: 100, null: false
  end

  create_table "tipo_documento_personal", primary_key: "td_id", id: :string, limit: 1, collation: "latin1_swedish_ci", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "td_nombre", limit: 10, collation: "latin1_swedish_ci"
  end

  create_table "tipo_empresa", primary_key: "te_id", id: :string, limit: 2, collation: "latin1_swedish_ci", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "te_nombre", limit: 60, collation: "latin1_swedish_ci"
  end

  create_table "tipo_etnia", primary_key: "tet_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "tet_nombre", limit: 40, collation: "latin1_swedish_ci"
    t.string "codigo",     limit: 45
  end

  create_table "tipo_evaluacion", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "tev_id",          limit: 4
    t.string  "tev_nombre",      limit: 20
    t.string  "tev_descripcion", limit: 80
    t.boolean "tev_estado"
  end

  create_table "tipo_feriado", primary_key: "tf_id", id: :string, limit: 2, collation: "latin1_swedish_ci", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "tf_nombre", limit: 20, collation: "latin1_swedish_ci"
  end

  create_table "tipo_grupo_docente", primary_key: "tgd_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "tgd_descripcion", limit: 100, collation: "latin1_swedish_ci"
    t.boolean "tgd_estado"
  end

  create_table "tipo_institucion", primary_key: "inst_tipo", id: :string, limit: 2, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "inst_desc", limit: 16, null: false
  end

  create_table "tipo_relacion_trabajo", primary_key: "trt_id", id: :string, limit: 4, collation: "latin1_swedish_ci", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "trt_nombre", limit: 60, collation: "latin1_swedish_ci"
  end

  create_table "tipo_seccion", primary_key: "tsc_id", id: :string, limit: 3, collation: "latin1_swedish_ci", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "tsc_nombre", limit: 13, collation: "latin1_swedish_ci"
  end

  create_table "titulados", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "facultad",          limit: 100
    t.string "nivel",             limit: 45
    t.string "titulo",            limit: 200
    t.string "cedula",            limit: 20
    t.string "nombre",            limit: 100
    t.string "folio",             limit: 45
    t.string "acta",              limit: 45
    t.date   "fecha_inscripcion"
    t.date   "fecha_inicio"
    t.date   "fecha_egreso"
    t.date   "fecha_grado"
    t.string "modalidad",         limit: 45
    t.string "carrera",           limit: 100
    t.string "sede",              limit: 45
  end

  create_table "titulo", primary_key: "id_tc", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "registramos la " do |t|
    t.boolean "estado_tc",               null: false
    t.string  "nomb_titulo", limit: 100, null: false, comment: "nombre del titulo que otorga la carrera"
    t.string  "nivel",       limit: 20,  null: false, comment: "nivel de carrera"
  end

  create_table "ubicacion_geografica", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "provincia", limit: 60,  null: false, comment: "provincia"
    t.string "canton",    limit: 60,  null: false, comment: "canton"
    t.string "parroquia", limit: 100, null: false, comment: "parroquia"
  end

  create_table "usuario", primary_key: "LoginUsu", id: :string, limit: 20, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ClaveUsu",            limit: 100
    t.string   "StatusUsu",           limit: 1
    t.string   "NombUsu",             limit: 100
    t.string   "idperfil",            limit: 15,  null: false
    t.string   "ciinfper",            limit: 20
    t.string   "idcarr",              limit: 200
    t.string   "id_actdist",          limit: 100, null: false
    t.boolean  "usa_biometrico",                  null: false
    t.datetime "fecha_reg",                       null: false, comment: "Fecha de alta del usuario en el sistema"
    t.datetime "fecha_ultimo_acceso",             null: false
    t.string   "titulo",              limit: 15
    t.index ["idperfil"], name: "fk_usuario_perfil1", using: :btree
  end

  add_foreign_key "academico_alumno", "informacionpersonal", column: "CIInfPer", primary_key: "CIInfPer", name: "academico_alumno_ibfk_1", on_update: :cascade
  add_foreign_key "asistencia_alumno", "notasalumnoasignatura", column: "ciinfper", primary_key: "CIInfPer", name: "asistencia_alumno_ibfk_2", on_update: :cascade
  add_foreign_key "asistencia_alumno", "notasalumnoasignatura", column: "idnaa", primary_key: "idnaa", name: "asistencia_alumno_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "docenteperasig", "periodolectivo", column: "idPer", primary_key: "idper", name: "docenteperasig_ibfk_1"
  add_foreign_key "mallacurricularperiodo", "malla_curricular", column: "idMc", primary_key: "idMc", name: "mallacurricularperiodo_ibfk_1"
  add_foreign_key "mallacurricularperiodo", "periodolectivo", column: "idPer", primary_key: "idper", name: "mallacurricularperiodo_ibfk_2"
  add_foreign_key "matricula", "carrera", column: "idCarr", primary_key: "idCarr", name: "matricula_ibfk_2"
  add_foreign_key "matricula", "informacionpersonal", column: "CIInfPer", primary_key: "CIInfPer", name: "matricula_ibfk_1", on_update: :cascade
  add_foreign_key "matricula", "periodolectivo", column: "idPer", primary_key: "idper", name: "matricula_ibfk_3"
  add_foreign_key "notasalumnoasignatura", "asignatura", column: "idAsig", primary_key: "IdAsig", name: "notasalumnoasignatura_ibfk_4", on_update: :cascade
  add_foreign_key "notasalumnoasignatura", "informacionpersonal", column: "CIInfPer", primary_key: "CIInfPer", name: "notasalumnoasignatura_ibfk_1", on_update: :cascade
  add_foreign_key "silabo", "docenteperasig", column: "dpa_id", primary_key: "dpa_id", name: "silabo_ibfk_1"
end
