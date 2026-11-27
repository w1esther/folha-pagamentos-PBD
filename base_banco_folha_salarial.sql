create dabatabase folha_salaria_2_pbd;

use folha_salaria_2_pbd;

create table EMPRESA (
	CNPJ char(14) not null primary key,
	Nome varchar(150) not null,
	Estado char(2),
	Cidade varchar(100),
	Rua varchar(150),
	Numero varchar(10),
	bairro varchar(100)
);

create table CARGO (
	ID int not null primary key,
	Nome varchar(100),
	empresa_CNPJ char(14),
	salario_base decimal(10, 2),
	constraint pk_CNPJ_empresa foreign key (empresa_CNPJ) references EMPRESA(CNPJ)
);

create table SETOR (
	ID int not null primary key,
	Nome varchar(100)
);

create table CARGO_SETOR (
	id_cargo int not null,
	id_setor int not null,
	primary key (id_cargo, id_setor),
	constraint fk_cargo foreign key (id_cargo) references CARGO(ID),
	constraint fk_setor foreign key (id_setor) references SETOR(ID)
);

create table FUNCIONARIO (
	CPF char(11) not null primary key, 
	nome varchar(150),
	id_cargo int not null,
	id_setor int not null,
	data_admissao date,
	situacao_atividade boolean,
	de_ferias boolean,
	estado char(2),
	cidade varchar(100),
	bairro varchar(100),
	rua varchar(150),
	numero varchar(10),
	email varchar(254) unique key,
	celular_pessoal varchar(20) unique key,
	telefone_fixo varchar(20) unique key,
	salaria_base decimal(10, 2),
	constraint fk_cargo_funcionario foreign key (id_cargo) references CARGO(ID),
	constraint fk_setor_funcionario foreign key (id_setor) references SETOR(ID)
);

create table HORAS_EXTRAS(
	id INT not null primary key,
	data_registro date,
	qntd_faltas_n_justificada int,
	CPF_funcionario char(11) unique key,
	constraint fk_CPF_funcionario foreign key (CPF_funcionario) references FUNCIONARIO(CPF)
);

alter table HORAS_EXTRAS
change qntd_faltas_n_justificada num_horas float;

create table FALTAS(
	id int not null primary key, 
	data_registro date,
	CPF_funcionario char(11) unique key,
	numero_horas decimal(10, 2),
	constraint fk_CPF_funcionario_faltas foreign key (CPF_funcionario) references FUNCIONARIO(CPF)
);

alter table FALTAS
change numero_horas qntd_faltas_n_justificadas int;

create table ATRASOS(
	id int not null primary key, 
	data_registro date,
	CPF_funcionario char(11) unique key,
	numero_horas decimal(10, 2),
	constraint fk_CPF_funcionario_atrasos foreign key (CPF_funcionario) references FUNCIONARIO(CPF)
);

create table CALCULO_REMUNERACAO(
	salario_base int,
	id_folha int unique key,
	data_calculo DATE,
	CPF_funcionario char(11) unique key,
	id_calculo int primary key,
	descontos_impostos int,
	contribuicao int,
	decime_terceiro boolean,
	constraint fk_CPF_funcionario_calculo foreign key (CPF_funcionario) references FUNCIONARIO(CPF),
	constraint fk_id_folha foreign key (id_folha) references FOLHA_SALARIAL(id)
);

create table FOLHA_SALARIAL(
	id int not null primary key,
	data_folha date,
	empresa_CNPJ char(14) unique key,
	remuneracao_liquida decimal(10, 2),
	remuneracao_bruta decimal(10, 2),
	constraint fk_CNPJ_empresa_folha foreign key (empresa_CNPJ) references EMPRESA(CNPJ)
);

ALTER TABLE CALCULO_REMUNERACAO
DROP FOREIGN KEY fk_id_folha;

ALTER TABLE CALCULO_REMUNERACAO
DROP INDEX id_folha;

ALTER TABLE CALCULO_REMUNERACAO
ADD CONSTRAINT fk_id_folha
FOREIGN KEY (id_folha)
REFERENCES FOLHA_SALARIAL(id);

alter table calculo_remuneracao
add salario_final decimal(10, 2);
