class Resume {
  final ContactInfo info;
  final List<WorkExperience> workExperience;
  final List<Education> education;
  final Skills skills;

  const Resume({
    required this.info,
    required this.workExperience,
    required this.education,
    required this.skills,
  });
}

class ContactInfo {
  final String nameSurname;
  final String job;
  final String email;
  final String pNumber;
  final String address;

  const ContactInfo({
    required this.nameSurname,
    required this.job,
    required this.email,
    required this.pNumber,
    required this.address,
  });
}

class WorkExperience {
  final String companyName;
  final String position;
  final String startDate;
  final String endDate;


  const WorkExperience({
    required this.companyName,
    required this.position,
    required this.startDate,
    required this.endDate,
  });
}

class Education {
  final String schoolName;
  final String? departmant;
  final String startDate;
  final String endDate;

  const Education({
    required this.schoolName,
    this.departmant,
    required this.startDate,
    required this.endDate,
  });
}

class Skills {
  final String description;

  const Skills({
    required this.description,
  });
}