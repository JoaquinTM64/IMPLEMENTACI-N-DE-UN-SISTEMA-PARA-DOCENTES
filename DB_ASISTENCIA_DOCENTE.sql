/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     5/12/2025 17:57:20                           */
/*==============================================================*/


drop table if exists asistencia;

drop table if exists docentes;

drop table if exists hoja_asistencia;

drop table if exists horarios;

drop table if exists incidencia;

drop table if exists justificacion;

drop table if exists nivel_educativo;

drop table if exists periodo_academico;

drop table if exists reporte_mensual;

drop table if exists roles;

drop table if exists turno;

drop table if exists usuarios;

/*==============================================================*/
/* Table: asistencia                                            */
/*==============================================================*/
create table asistencia
(
   id_asistencia        int(11) not null,
   id_docente           int(11) not null,
   fecha                date not null,
   hora_entrada         time default NULL,
   hora_salida          time default NULL,
   estado               enum('Presente','Tarde','Falta','Justificado') default 'Presente',
   primary key (id_asistencia)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*==============================================================*/
/* Table: docentes                                              */
/*==============================================================*/
create table docentes
(
   id_docente           int(11) not null,
   id_usuario           int(11) not null,
   id_nivel             int(11) default NULL,
   titulo_academico     varchar(100) default NULL,
   primary key (id_docente)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*==============================================================*/
/* Table: hoja_asistencia                                       */
/*==============================================================*/
create table hoja_asistencia
(
   id_hoja              int(11) not null,
   id_docente           int(11) not null,
   id_periodo           int(11) not null,
   mes                  varchar(20) not null,
   total_asistencias    int(11) default 0,
   total_faltas         int(11) default 0,
   total_justificaciones int(11) default 0,
   primary key (id_hoja)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*==============================================================*/
/* Table: horarios                                              */
/*==============================================================*/
create table horarios
(
   id_horario           int(11) not null,
   id_docente           int(11) not null,
   id_turno             int(11) not null,
   dia_semana           enum('Lunes','Martes','Miercoles','Jueves','Viernes') not null,
   hora_inicio          time not null,
   hora_fin             time not null,
   primary key (id_horario)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*==============================================================*/
/* Table: incidencia                                            */
/*==============================================================*/
create table incidencia
(
   id_incidencia        int(11) not null,
   id_asistencia        int(11) not null,
   descripcion          text default NULL,
   tipo                 enum('Retraso','Falta','Otra') default 'Otra',
   primary key (id_incidencia)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*==============================================================*/
/* Table: justificacion                                         */
/*==============================================================*/
create table justificacion
(
   id_justificacion     int(11) not null,
   id_incidencia        int(11) not null,
   motivo               text not null,
   fecha_envio          date not null,
   estado               enum('Pendiente','Aprobado','Rechazado') default 'Pendiente',
   primary key (id_justificacion)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*==============================================================*/
/* Table: nivel_educativo                                       */
/*==============================================================*/
create table nivel_educativo
(
   id_nivel             int(11) not null,
   nombre               varchar(100) not null,
   primary key (id_nivel)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*==============================================================*/
/* Table: periodo_academico                                     */
/*==============================================================*/
create table periodo_academico
(
   id_periodo           int(11) not null,
   nombre               varchar(100) not null,
   fecha_inicio         date not null,
   fecha_fin            date not null,
   activo               tinyint(1) default 1,
   primary key (id_periodo)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*==============================================================*/
/* Table: reporte_mensual                                       */
/*==============================================================*/
create table reporte_mensual
(
   id_reporte           int(11) not null,
   id_periodo           int(11) not null,
   mes                  varchar(20) not null,
   fecha_generacion     date not null,
   generado_por         int(11) not null,
   primary key (id_reporte)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*==============================================================*/
/* Table: roles                                                 */
/*==============================================================*/
create table roles
(
   id_rol               int(11) not null,
   nombre               varchar(50) not null,
   primary key (id_rol)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*==============================================================*/
/* Table: turno                                                 */
/*==============================================================*/
create table turno
(
   id_turno             int(11) not null,
   nombre               varchar(50) not null,
   hora_inicio          time not null,
   hora_fin             time not null,
   primary key (id_turno)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*==============================================================*/
/* Table: usuarios                                              */
/*==============================================================*/
create table usuarios
(
   id_usuario           int(11) not null,
   nombre               varchar(100) not null,
   apellido             varchar(100) not null,
   correo               varchar(100) not null,
   contrasena           varchar(255) not null,
   id_rol               int(11) not null,
   activo               tinyint(1) default 1,
   primary key (id_usuario)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

alter table asistencia add constraint asistencia_ibfk_1 foreign key (id_docente)
      references docentes (id_docente);

alter table docentes add constraint docentes_ibfk_1 foreign key (id_usuario)
      references usuarios (id_usuario);

alter table hoja_asistencia add constraint hoja_asistencia_ibfk_1 foreign key (id_docente)
      references docentes (id_docente);

alter table horarios add constraint horarios_ibfk_1 foreign key (id_docente)
      references docentes (id_docente);

alter table incidencia add constraint incidencia_ibfk_1 foreign key (id_asistencia)
      references asistencia (id_asistencia);

alter table justificacion add constraint justificacion_ibfk_1 foreign key (id_incidencia)
      references incidencia (id_incidencia);

alter table reporte_mensual add constraint reporte_mensual_ibfk_1 foreign key (id_periodo)
      references periodo_academico (id_periodo);

alter table usuarios add constraint usuarios_ibfk_1 foreign key (id_rol)
      references roles (id_rol);

