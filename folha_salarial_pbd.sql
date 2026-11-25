-- CRIAÇÃO DA BASE DO BANCO DE DADOS

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

-- INSERÇÃO DOS DADOS NAS TABELAS

INSERT INTO EMPRESA
(CNPJ, Nome, Estado, Cidade, Rua, Numero, bairro)
VALUES
('12345678000190', 'NovaTech', 'RN', 'Ceará-Mirim', 'Rua das Acácias', '120', 'Centro');


INSERT INTO CARGO
(ID, Nome, empresa_CNPJ, salario_base)
VALUES
(1, 'Desenvolvedor Backend', '12345678000190', 6500.00),
(2, 'Desenvolvedor Frontend', '12345678000190', 5800.00),
(3, 'Desenvolvedor Full Stack', '12345678000190', 7500.00),
(4, 'Analista de Sistemas', '12345678000190', 5200.00),
(5, 'Analista de Banco de Dados', '12345678000190', 5500.00),
(6, 'Administrador de Banco de Dados', '12345678000190', 6800.00),
(7, 'Engenheiro de Software', '12345678000190', 8500.00),
(8, 'Analista de Segurança da Informação', '12345678000190', 6200.00),
(9, 'Técnico de Suporte', '12345678000190', 2500.00),
(10, 'Analista de Infraestrutura', '12345678000190', 4800.00),
(11, 'Gerente de Projetos', '12345678000190', 9000.00),
(12, 'Analista de Recursos Humanos', '12345678000190', 3500.00),
(13, 'Assistente Administrativo', '12345678000190', 2200.00),
(14, 'Analista Financeiro', '12345678000190', 4000.00),
(15, 'Contador', '12345678000190', 5500.00),
(16, 'Designer UX/UI', '12345678000190', 4500.00),
(17, 'Analista de Qualidade de Software', '12345678000190', 4200.00),
(18, 'Cientista de Dados', '12345678000190', 7800.00),
(19, 'Estagiário de Desenvolvimento', '12345678000190', 1200.00),
(20, 'Diretor de Tecnologia', '12345678000190', 15000.00);

INSERT INTO SETOR
(id, nome)
VALUES
(1, 'Desenvolvimento de Software'),
(2, 'Análise e Sistemas'),
(3, 'Banco de Dados'),
(4, 'Segurança da Informação'),
(5, 'Infraestrutura e Suporte'),
(6, 'Gestão de Projetos'),
(7, 'Recursos Humanos'),
(8, 'Administrativo'),
(9, 'Financeiro e Contabilidade'),
(10, 'Dados e Inteligência Artificial'),
(11, 'Design e Experiência do Usuário'),
(12, 'Qualidade de Software'),
(13, 'Diretoria de Tecnologia');

INSERT INTO CARGO_SETOR
(id_cargo, id_setor)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 3),
(6, 3),
(7, 1),
(8, 4),
(9, 5),
(10, 5),
(11, 6),
(12, 7),
(13, 8),
(14, 9),
(15, 9),
(16, 11),
(17, 12),
(18, 10),
(19, 1),
(20, 13);

INSERT INTO FUNCIONARIO
(CPF, nome, id_cargo, id_setor, data_admissao,
 situacao_atividade, de_ferias, estado, cidade, bairro,
 rua, numero, email, celular_pessoal, telefone_fixo, salaria_base)
VALUES
('90000000001', 'Ana Beatriz Oliveira', 1, 1, '2022-03-15', TRUE, FALSE, 'RN', 'Ceará-Mirim', 'Centro', 'Rua das Flores', '120', 'ana01@empresa.example', '84991000001', '8432000001', 6500.00),
('90000000002', 'Carlos Eduardo Santos', 2, 1, '2021-07-20', TRUE, FALSE, 'RN', 'Natal', 'Tirol', 'Rua Potengi', '45', 'carlos02@empresa.example', '84991000002', '8432000002', 5800.00),
('90000000003', 'Mariana Costa Ferreira', 3, 1, '2020-01-10', TRUE, TRUE, 'RN', 'Parnamirim', 'Nova Parnamirim', 'Rua das Palmeiras', '89', 'mariana03@empresa.example', '84991000003', '8432000003', 7500.00),
('90000000004', 'Pedro Henrique Lima', 4, 2, '2023-05-08', TRUE, FALSE, 'RN', 'Natal', 'Lagoa Nova', 'Rua São José', '210', 'pedro04@empresa.example', '84991000004', '8432000004', 5200.00),
('90000000005', 'Juliana Martins Rocha', 5, 3, '2022-09-12', TRUE, FALSE, 'RN', 'Ceará-Mirim', 'Planalto', 'Rua João Pessoa', '55', 'juliana05@empresa.example', '84991000005', '8432000005', 5500.00),
('90000000006', 'Lucas Gabriel Alves', 6, 3, '2019-11-18', TRUE, FALSE, 'RN', 'Natal', 'Alecrim', 'Rua Amaro Barreto', '300', 'lucas06@empresa.example', '84991000006', '8432000006', 6800.00),
('90000000007', 'Fernanda Souza Ribeiro', 7, 1, '2021-02-22', TRUE, FALSE, 'RN', 'Parnamirim', 'Centro', 'Rua Bela Vista', '77', 'fernanda07@empresa.example', '84991000007', '8432000007', 8500.00),
('90000000008', 'Rafael Mendes Costa', 8, 4, '2023-08-14', TRUE, FALSE, 'RN', 'Natal', 'Petrópolis', 'Rua Trairi', '150', 'rafael08@empresa.example', '84991000008', '8432000008', 6200.00),
('90000000009', 'Camila Rodrigues Melo', 9, 5, '2024-01-05', TRUE, FALSE, 'RN', 'Ceará-Mirim', 'Centro', 'Rua do Comércio', '32', 'camila09@empresa.example', '84991000009', '8432000009', 2500.00),
('90000000010', 'Bruno Carvalho Silva', 10, 5, '2022-06-17', TRUE, FALSE, 'RN', 'Natal', 'Capim Macio', 'Rua das Dunas', '98', 'bruno10@empresa.example', '84991000010', '8432000010', 4800.00),
('90000000011', 'Isabela Fernandes Lima', 11, 6, '2020-04-13', TRUE, FALSE, 'RN', 'Natal', 'Candelária', 'Rua dos Girassóis', '180', 'isabela11@empresa.example', '84991000011', '8432000011', 9000.00),
('90000000012', 'Thiago Oliveira Martins', 12, 7, '2023-02-01', TRUE, FALSE, 'RN', 'Parnamirim', 'Emaús', 'Rua Central', '65', 'thiago12@empresa.example', '84991000012', '8432000012', 3500.00),
('90000000013', 'Larissa Gomes Pereira', 13, 8, '2024-03-11', TRUE, FALSE, 'RN', 'Ceará-Mirim', 'Santa Águeda', 'Rua Projetada', '41', 'larissa13@empresa.example', '84991000013', '8432000013', 2200.00),
('90000000014', 'Matheus Araújo Santos', 14, 9, '2021-10-25', TRUE, FALSE, 'RN', 'Natal', 'Lagoa Nova', 'Rua dos Jasmins', '220', 'matheus14@empresa.example', '84991000014', '8432000014', 4000.00),
('90000000015', 'Beatriz Almeida Costa', 15, 9, '2019-08-19', TRUE, FALSE, 'RN', 'Macaíba', 'Centro', 'Rua da Matriz', '19', 'beatriz15@empresa.example', '84991000015', '8432000015', 5500.00),
('90000000016', 'Gabriel Nascimento Souza', 16, 11, '2022-12-05', TRUE, FALSE, 'RN', 'Natal', 'Tirol', 'Rua Açu', '110', 'gabriel16@empresa.example', '84991000016', '8432000016', 4500.00),
('90000000017', 'Letícia Barbosa Ferreira', 17, 12, '2023-06-26', TRUE, FALSE, 'RN', 'Parnamirim', 'Centro', 'Rua da Paz', '73', 'leticia17@empresa.example', '84991000017', '8432000017', 4200.00),
('90000000018', 'Vinícius Castro Almeida', 18, 10, '2021-04-07', TRUE, FALSE, 'RN', 'Natal', 'Ponta Negra', 'Rua Praia de Pipa', '88', 'vinicius18@empresa.example', '84991000018', '8432000018', 7800.00),
('90000000019', 'Eduarda Ribeiro Melo', 19, 1, '2025-02-10', TRUE, FALSE, 'RN', 'Ceará-Mirim', 'Centro', 'Rua Nova', '25', 'eduarda19@empresa.example', '84991000019', '8432000019', 1200.00),
('90000000020', 'André Luiz Carvalho', 20, 13, '2018-01-15', TRUE, FALSE, 'RN', 'Natal', 'Petrópolis', 'Rua Ceará', '500', 'andre20@empresa.example', '84991000020', '8432000020', 15000.00),
('90000000021', 'Sofia Martins Oliveira', 1, 1, '2024-05-20', TRUE, FALSE, 'RN', 'Natal', 'Alecrim', 'Rua dos Andradas', '60', 'sofia21@empresa.example', '84991000021', '8432000021', 6500.00),
('90000000022', 'Daniel Henrique Rocha', 2, 1, '2022-08-03', TRUE, FALSE, 'RN', 'Macaíba', 'Centro', 'Rua São Miguel', '91', 'daniel22@empresa.example', '84991000022', '8432000022', 5800.00),
('90000000023', 'Amanda Cristina Alves', 3, 1, '2021-09-14', TRUE, FALSE, 'RN', 'Parnamirim', 'Cohabinal', 'Rua das Acácias', '105', 'amanda23@empresa.example', '84991000023', '8432000023', 7500.00),
('90000000024', 'Felipe Augusto Lima', 4, 2, '2020-07-06', TRUE, FALSE, 'RN', 'Natal', ' Tirol', 'Rua Jundiaí', '72', 'felipe24@empresa.example', '84991000024', '8432000024', 5200.00),
('90000000025', 'Vitória Mendes Santos', 5, 3, '2023-11-09', TRUE, FALSE, 'RN', 'Ceará-Mirim', 'Centro', 'Rua do Sol', '150', 'vitoria25@empresa.example', '84991000025', '8432000025', 5500.00),
('90000000026', 'Gustavo Pereira Costa', 6, 3, '2022-02-14', TRUE, FALSE, 'RN', 'Natal', 'Lagoa Nova', 'Rua dos Ipês', '33', 'gustavo26@empresa.example', '84991000026', '8432000026', 6800.00),
('90000000027', 'Manuela Ferreira Silva', 7, 1, '2019-05-21', TRUE, FALSE, 'RN', 'Parnamirim', 'Nova Parnamirim', 'Rua das Orquídeas', '44', 'manuela27@empresa.example', '84991000027', '8432000027', 8500.00),
('90000000028', 'Leonardo Gomes Ribeiro', 8, 4, '2024-07-15', TRUE, FALSE, 'RN', 'Natal', 'Capim Macio', 'Rua dos Pinheiros', '67', 'leonardo28@empresa.example', '84991000028', '8432000028', 6200.00),
('90000000029', 'Helena Costa Martins', 9, 5, '2023-03-02', TRUE, FALSE, 'RN', 'Ceará-Mirim', 'Planalto', 'Rua da Esperança', '29', 'helena29@empresa.example', '84991000029', '8432000029', 2500.00),
('90000000030', 'Samuel Oliveira Araújo', 10, 5, '2021-12-13', TRUE, FALSE, 'RN', 'Natal', 'Alecrim', 'Rua Presidente Quaresma', '115', 'samuel30@empresa.example', '84991000030', '8432000030', 4800.00),
('90000000031', 'Clara Beatriz Nascimento', 11, 6, '2020-10-19', TRUE, FALSE, 'RN', 'Natal', 'Candelária', 'Rua das Flores', '205', 'clara31@empresa.example', '84991000031', '8432000031', 9000.00),
('90000000032', 'Enzo Gabriel Carvalho', 12, 7, '2022-04-04', TRUE, FALSE, 'RN', 'Parnamirim', 'Centro', 'Rua São Francisco', '80', 'enzo32@empresa.example', '84991000032', '8432000032', 3500.00),
('90000000033', 'Luana Rodrigues Melo', 13, 8, '2024-09-23', TRUE, FALSE, 'RN', 'Ceará-Mirim', 'Centro', 'Rua da Liberdade', '14', 'luana33@empresa.example', '84991000033', '8432000033', 2200.00),
('90000000034', 'Diego Martins Ferreira', 14, 9, '2023-01-16', TRUE, FALSE, 'RN', 'Natal', 'Tirol', 'Rua Mossoró', '170', 'diego34@empresa.example', '84991000034', '8432000034', 4000.00),
('90000000035', 'Alice Souza Almeida', 15, 9, '2020-06-08', TRUE, FALSE, 'RN', 'Macaíba', 'Centro', 'Rua do Cruzeiro', '52', 'alice35@empresa.example', '84991000035', '8432000035', 5500.00),
('90000000036', 'Igor Henrique Santos', 16, 11, '2022-11-28', TRUE, FALSE, 'RN', 'Natal', 'Ponta Negra', 'Rua Praia de Genipabu', '90', 'igor36@empresa.example', '84991000036', '8432000036', 4500.00),
('90000000037', 'Rebeca Lima Costa', 17, 12, '2024-02-19', TRUE, FALSE, 'RN', 'Parnamirim', 'Emaús', 'Rua das Margaridas', '38', 'rebeca37@empresa.example', '84991000037', '8432000037', 4200.00),
('90000000038', 'Murilo Barbosa Rocha', 18, 10, '2021-08-30', TRUE, FALSE, 'RN', 'Natal', 'Lagoa Nova', 'Rua dos Engenheiros', '101', 'murilo38@empresa.example', '84991000038', '8432000038', 7800.00),
('90000000039', 'Laura Fernandes Oliveira', 19, 1, '2025-04-01', TRUE, FALSE, 'RN', 'Ceará-Mirim', 'Centro', 'Rua São Pedro', '66', 'laura39@empresa.example', '84991000039', '8432000039', 1200.00),
('90000000040', 'Roberto Carlos Mendes', 20, 13, '2018-09-10', TRUE, FALSE, 'RN', 'Natal', 'Petrópolis', 'Rua Potiguar', '400', 'roberto40@empresa.example', '84991000040', '8432000040', 15000.00),
('90000000041', 'Bianca Alves Pereira', 1, 1, '2023-10-16', TRUE, FALSE, 'RN', 'Natal', 'Lagoa Nova', 'Rua das Palmeiras', '130', 'bianca41@empresa.example', '84991000041', '8432000041', 6500.00),
('90000000042', 'Arthur Gabriel Souza', 2, 1, '2022-01-24', TRUE, FALSE, 'RN', 'Parnamirim', 'Centro', 'Rua Nova Esperança', '75', 'arthur42@empresa.example', '84991000042', '8432000042', 5800.00),
('90000000043', 'Nicole Martins Ribeiro', 3, 1, '2021-03-17', TRUE, FALSE, 'RN', 'Ceará-Mirim', 'Centro', 'Rua Bela Vista', '90', 'nicole43@empresa.example', '84991000043', '8432000043', 7500.00),
('90000000044', 'João Pedro Ferreira', 4, 2, '2024-06-12', TRUE, FALSE, 'RN', 'Natal', 'Alecrim', 'Rua dos Expedicionários', '22', 'joao44@empresa.example', '84991000044', '8432000044', 5200.00),
('90000000045', 'Isadora Gomes Silva', 5, 3, '2023-07-03', TRUE, FALSE, 'RN', 'Macaíba', 'Centro', 'Rua da Aurora', '48', 'isadora45@empresa.example', '84991000045', '8432000045', 5500.00),
('90000000046', 'Caio Henrique Almeida', 6, 3, '2020-02-11', TRUE, FALSE, 'RN', 'Natal', 'Tirol', 'Rua Apodi', '155', 'caio46@empresa.example', '84991000046', '8432000046', 6800.00),
('90000000047', 'Melissa Costa Rodrigues', 7, 1, '2022-05-09', TRUE, FALSE, 'RN', 'Parnamirim', 'Nova Parnamirim', 'Rua das Oliveiras', '63', 'melissa47@empresa.example', '84991000047', '8432000047', 8500.00),
('90000000048', 'Davi Lucas Martins', 8, 4, '2024-10-07', TRUE, FALSE, 'RN', 'Natal', 'Candelária', 'Rua dos Girassóis', '118', 'davi48@empresa.example', '84991000048', '8432000048', 6200.00),
('90000000049', 'Emanuelly Rocha Santos', 9, 5, '2025-01-20', TRUE, FALSE, 'RN', 'Ceará-Mirim', 'Centro', 'Rua João XXIII', '35', 'emanuelly49@empresa.example', '84991000049', '8432000049', 2500.00),
('90000000050', 'Nicolas Oliveira Costa', 10, 5, '2023-12-04', TRUE, FALSE, 'RN', 'Natal', 'Capim Macio', 'Rua das Acácias', '200', 'nicolas50@empresa.example', '84991000050', '8432000050', 4800.00);

INSERT INTO HORAS_EXTRAS
(id, data_registro, num_horas, CPF_funcionario)
VALUES
(1, '2026-10-05', 2.5, '90000000001'),
(2, '2026-10-07', 3.0, '90000000003'),
(3, '2026-10-09', 1.5, '90000000005'),
(4, '2026-10-12', 4.0, '90000000007'),
(5, '2026-10-14', 2.0, '90000000010'),
(6, '2026-10-16', 3.5, '90000000015'),
(7, '2026-10-19', 1.0, '90000000018'),
(8, '2026-10-21', 2.5, '90000000023'),
(9, '2026-10-23', 4.0, '90000000031'),
(10, '2026-10-26', 1.5, '90000000042');

INSERT INTO FALTAS
(id, data_registro, CPF_funcionario, qntd_faltas_n_justificadas)
VALUES
(1, '2026-10-02', '90000000002', 1),
(2, '2026-10-04', '90000000004', 2),
(3, '2026-10-06', '90000000008', 1),
(4, '2026-10-08', '90000000011', 1),
(5, '2026-10-10', '90000000014', 3),
(6, '2026-10-13', '90000000020', 1),
(7, '2026-10-15', '90000000025', 2),
(8, '2026-10-18', '90000000033', 1),
(9, '2026-10-20', '90000000039', 2),
(10, '2026-10-22', '90000000047', 1);

INSERT INTO ATRASOS
(id, data_registro, CPF_funcionario, numero_horas)
VALUES
(1, '2026-10-03', '90000000001', 0.50),
(2, '2026-10-05', '90000000006', 0.25),
(3, '2026-10-07', '90000000009', 1.00),
(4, '2026-10-09', '90000000012', 0.75),
(5, '2026-10-11', '90000000016', 0.50),
(6, '2026-10-14', '90000000021', 0.25),
(7, '2026-10-16', '90000000028', 1.50),
(8, '2026-10-19', '90000000034', 0.50),
(9, '2026-10-21', '90000000040', 0.75),
(10, '2026-10-24', '90000000050', 1.00);

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

INSERT INTO CALCULO_REMUNERACAO
(salario_base, id_folha, data_calculo, CPF_funcionario, id_calculo, descontos_impostos, contribuicao, decime_terceiro)
VALUES
(6500, 1, '2026-10-31', '90000000001', 1, 325, 520, FALSE),
(5800, 1, '2026-10-31', '90000000002', 2, 290, 464, FALSE),
(7500, 1, '2026-10-31', '90000000003', 3, 375, 600, FALSE),
(5200, 1, '2026-10-31', '90000000004', 4, 260, 416, FALSE),
(5500, 1, '2026-10-31', '90000000005', 5, 275, 440, FALSE),
(6800, 1, '2026-10-31', '90000000006', 6, 340, 544, FALSE),
(8500, 1, '2026-10-31', '90000000007', 7, 425, 680, FALSE),
(6200, 1, '2026-10-31', '90000000008', 8, 310, 496, FALSE),
(2500, 1, '2026-10-31', '90000000009', 9, 125, 200, FALSE),
(4800, 1, '2026-10-31', '90000000010', 10, 240, 384, FALSE),
(9000, 1, '2026-10-31', '90000000011', 11, 450, 720, FALSE),
(3500, 1, '2026-10-31', '90000000012', 12, 175, 280, FALSE),
(2200, 1, '2026-10-31', '90000000013', 13, 110, 176, FALSE),
(4000, 1, '2026-10-31', '90000000014', 14, 200, 320, FALSE),
(5500, 1, '2026-10-31', '90000000015', 15, 275, 440, FALSE),
(4500, 1, '2026-10-31', '90000000016', 16, 225, 360, FALSE),
(4200, 1, '2026-10-31', '90000000017', 17, 210, 336, FALSE),
(7800, 1, '2026-10-31', '90000000018', 18, 390, 624, FALSE),
(1200, 1, '2026-10-31', '90000000019', 19, 60, 96, FALSE),
(15000, 1, '2026-10-31', '90000000020', 20, 750, 1200, FALSE),
(6500, 1, '2026-10-31', '90000000021', 21, 325, 520, FALSE),
(5800, 1, '2026-10-31', '90000000022', 22, 290, 464, FALSE),
(7500, 1, '2026-10-31', '90000000023', 23, 375, 600, FALSE),
(5200, 1, '2026-10-31', '90000000024', 24, 260, 416, FALSE),
(5500, 1, '2026-10-31', '90000000025', 25, 275, 440, FALSE),
(6800, 1, '2026-10-31', '90000000026', 26, 340, 544, FALSE),
(8500, 1, '2026-10-31', '90000000027', 27, 425, 680, FALSE),
(6200, 1, '2026-10-31', '90000000028', 28, 310, 496, FALSE),
(2500, 1, '2026-10-31', '90000000029', 29, 125, 200, FALSE),
(4800, 1, '2026-10-31', '90000000030', 30, 240, 384, FALSE),
(9000, 1, '2026-10-31', '90000000031', 31, 450, 720, FALSE),
(3500, 1, '2026-10-31', '90000000032', 32, 175, 280, FALSE),
(2200, 1, '2026-10-31', '90000000033', 33, 110, 176, FALSE),
(4000, 1, '2026-10-31', '90000000034', 34, 200, 320, FALSE),
(5500, 1, '2026-10-31', '90000000035', 35, 275, 440, FALSE),
(4500, 1, '2026-10-31', '90000000036', 36, 225, 360, FALSE),
(4200, 1, '2026-10-31', '90000000037', 37, 210, 336, FALSE),
(7800, 1, '2026-10-31', '90000000038', 38, 390, 624, FALSE),
(1200, 1, '2026-10-31', '90000000039', 39, 60, 96, FALSE),
(15000, 1, '2026-10-31', '90000000040', 40, 750, 1200, FALSE),
(6500, 1, '2026-10-31', '90000000041', 41, 325, 520, FALSE),
(5800, 1, '2026-10-31', '90000000042', 42, 290, 464, FALSE),
(7500, 1, '2026-10-31', '90000000043', 43, 375, 600, FALSE),
(5200, 1, '2026-10-31', '90000000044', 44, 260, 416, FALSE),
(5500, 1, '2026-10-31', '90000000045', 45, 275, 440, FALSE),
(6800, 1, '2026-10-31', '90000000046', 46, 340, 544, FALSE),
(8500, 1, '2026-10-31', '90000000047', 47, 425, 680, FALSE),
(6200, 1, '2026-10-31', '90000000048', 48, 310, 496, FALSE),
(2500, 1, '2026-10-31', '90000000049', 49, 125, 200, FALSE),
(4800, 1, '2026-10-31', '90000000050', 50, 240, 384, FALSE);

UPDATE calculo_remuneracao
SET salario_final = CASE id_calculo
    WHEN 1 THEN 5655   WHEN 2 THEN 5046   WHEN 3 THEN 6525   WHEN 4 THEN 4524   WHEN 5 THEN 4785
    WHEN 6 THEN 5916   WHEN 7 THEN 7395   WHEN 8 THEN 5394   WHEN 9 THEN 2175   WHEN 10 THEN 4176
    WHEN 11 THEN 7830  WHEN 12 THEN 3045  WHEN 13 THEN 1914  WHEN 14 THEN 3480  WHEN 15 THEN 4785
    WHEN 16 THEN 3915  WHEN 17 THEN 3654  WHEN 18 THEN 6786  WHEN 19 THEN 1044  WHEN 20 THEN 13050
    WHEN 21 THEN 5655  WHEN 22 THEN 5046  WHEN 23 THEN 6525  WHEN 24 THEN 4524  WHEN 25 THEN 4785
    WHEN 26 THEN 5916  WHEN 27 THEN 7395  WHEN 28 THEN 5394  WHEN 29 THEN 2175  WHEN 30 THEN 4176
    WHEN 31 THEN 7830  WHEN 32 THEN 3045  WHEN 33 THEN 1914  WHEN 34 THEN 3480  WHEN 35 THEN 4785
    WHEN 36 THEN 3915  WHEN 37 THEN 3654  WHEN 38 THEN 6786  WHEN 39 THEN 1044  WHEN 40 THEN 13050
    WHEN 41 THEN 5655  WHEN 42 THEN 5046  WHEN 43 THEN 6525  WHEN 44 THEN 4524  WHEN 45 THEN 4785
    WHEN 46 THEN 5916  WHEN 47 THEN 7395  WHEN 48 THEN 5394  WHEN 49 THEN 2175  WHEN 50 THEN 4176
END
WHERE id_calculo BETWEEN 1 AND 50;

UPDATE calculo_remuneracao
SET salario_final = CASE id_calculo
    WHEN 1 THEN 6695   WHEN 2 THEN 5974   WHEN 3 THEN 7725   WHEN 4 THEN 5356   WHEN 5 THEN 5665
    WHEN 6 THEN 7004   WHEN 7 THEN 8755   WHEN 8 THEN 6386   WHEN 9 THEN 2575   WHEN 10 THEN 4944
    WHEN 11 THEN 9270  WHEN 12 THEN 3605  WHEN 13 THEN 2266  WHEN 14 THEN 4120  WHEN 15 THEN 5665
    WHEN 16 THEN 4635  WHEN 17 THEN 4326  WHEN 18 THEN 8034  WHEN 19 THEN 1236  WHEN 20 THEN 15450
    WHEN 21 THEN 6695  WHEN 22 THEN 5974  WHEN 23 THEN 7725  WHEN 24 THEN 5356  WHEN 25 THEN 5665
    WHEN 26 THEN 7004  WHEN 27 THEN 8755  WHEN 28 THEN 6386  WHEN 29 THEN 2575  WHEN 30 THEN 4944
    WHEN 31 THEN 9270  WHEN 32 THEN 3605  WHEN 33 THEN 2266  WHEN 34 THEN 4120  WHEN 35 THEN 5665
    WHEN 36 THEN 4635  WHEN 37 THEN 4326  WHEN 38 THEN 8034  WHEN 39 THEN 1236  WHEN 40 THEN 15450
    WHEN 41 THEN 6695  WHEN 42 THEN 5974  WHEN 43 THEN 7725  WHEN 44 THEN 5356  WHEN 45 THEN 5665
    WHEN 46 THEN 7004  WHEN 47 THEN 8755  WHEN 48 THEN 6386  WHEN 49 THEN 2575  WHEN 50 THEN 4944
END
WHERE id_calculo BETWEEN 1 AND 50;


INSERT INTO FOLHA_SALARIAL
(id, data_folha, empresa_CNPJ, remuneracao_liquida, remuneracao_bruta)
VALUES
(1, '2026-10-31', '12345678000190', 253779.00, 291700.00);

select *
from empresa;

select *
from cargo;

select *
from setor;

select *
from cargo_setor;

select *
from funcionario;

select *
from horas_extras;

select *
from faltas;

select *
from atrasos;

select *
from calculo_remuneracao;

select *
from folha_salarial;
