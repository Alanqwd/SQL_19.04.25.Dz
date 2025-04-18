CREATE DATABASE Academy;

go

use Academy;

CREATE TABLE curators(
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[name] NVARCHAR(max) not null,
	surname NVARCHAR(max) not null,

	CONSTRAINT name_of_curators CHECK(curators.[name] NOT LIKE '/\n\n/g'),
	CONSTRAINT surname_of_curators CHECK(curators.[name] NOT LIKE '/\n\n/g')
);
go

CREATE TABLE faculties(
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	financing MONEY not null DEFAULT(0),
	[name] NVARCHAR(100) not null UNIQUE,

	CONSTRAINT financing_of_faculties CHECK (faculties.financing > 0),
	CONSTRAINT name_of_faculties CHECK(faculties.[name] NOT LIKE '/\n\n/g'),
);
go

CREATE TABLE departmentss(
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	financing MONEY not null DEFAULT 0,
	[name] NVARCHAR(100) not null UNIQUE,
	facultyId INT not null,

	CONSTRAINT financing_of_deparments CHECK (departmentss.financing > 0),
	CONSTRAINT name_of_departments CHECK(departmentss.[name] NOT LIKE '/\n\n/g'),
	FOREIGN KEY (facultyId)  REFERENCES faculties(id)
);
go



CREATE TABLE groups(
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[name] NVARCHAR(10) not null UNIQUE,
	[year] INT not null,
	departmentId INT not null,

	CONSTRAINT name_of_groups CHECK(groups.[name] NOT LIKE '/\n\n/g'),
	CONSTRAINT year_of_groups CHECK (groups.[year] >= 1 and groups.[year] <= 5),
	FOREIGN KEY (departmentId) REFERENCES departments(id)
);
go

CREATE TABLE groupsCurators(
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	curatorId INT not null,
	groupId INT not null,

	foreign key (groupId) references groups(id),
	foreign key (curatorId) references curators(id)
);
go

CREATE TABLE subject1(
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[name] NVARCHAR(100) not null UNIQUE,


	constraint name_of_subject1 check (subject1.[name] not like '/\n\n/g')
);
go

CREATE TABLE teachers(
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[name] NVARCHAR(max) not null,
	salary MONEY not null,
	surname NVARCHAR(max) not null,

	constraint name_of_teachers check (teachers.[name] not like '/\n\n/g'),
	constraint salary_of_teachers check (teachers.salary > 0),
	constraint surname_of_teachers check (teachers.surname not like '/\n\n/g')
);
go

CREATE TABLE lectures (
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	lectureRoom NVARCHAR(max) not null,
	subjectId INT not null,
	teacherId INT not null,

	foreign key (teacherId) references teachers(id),
	foreign key (subjectId) references subject1(id),
	constraint room_of_lectures CHECK (lectures.lectureRoom not like '/\n\n/g'),
);
go

CREATE TABLE groupsLectures(
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	groupId INT not null,
	lectureId INT not null,


	foreign key (groupId) references groups(id),
	foreign key (lectureId) references lectures(id)
);
go





