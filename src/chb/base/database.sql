CREATE DATABASE adminsys DEFAULT CHARSET=utf8 DEFAULT COLLATE=utf8_general_ci;
/**
 * Create the main table for registration information.
 */
CREATE TABLE IF NOT EXISTS `register_info` (
/**
* Personal information.
* id="personalInfoPanel"
*/
  name                          VARCHAR(50),
  sex                           VARCHAR(50),
  birthday                      VARCHAR(50),
  people                        VARCHAR(50),
  identity                      VARCHAR(50),
  political                     VARCHAR(50),
  identityNo                    VARCHAR(50),

/**
 * Communication information.
 * id = "communicationInfoPanel"
 */
  phone                         VARCHAR(50),
  mobile                        VARCHAR(50),
  email                         VARCHAR(50),
  postalCode                    VARCHAR(50),
  address                       VARCHAR(100),
  unitName                      VARCHAR(100),
  unitAddress                   VARCHAR(100),
  unitPhone                     VARCHAR(50),
  unitPostalCode                VARCHAR(50),

/**
 * Other information.
 * id="otherInfoPanel"
 */
  pwd                           VARCHAR(50),
  confirmPwd                    VARCHAR(50),
  newOrOld                      VARCHAR(50),
  allDay                        VARCHAR(50),
  examType                      VARCHAR(50),
  comment                       VARCHAR(200),

/**
 * First choice college.
 * id="firstChoiceCollegePanel"
 */
  admitCardNo                   VARCHAR(50),
  firstChoiceCollegeName        VARCHAR(50),
  firstChoiceCollegePostalCode  VARCHAR(50),
  firstChoiceCollegeAddress     VARCHAR(100),
  firstChoiceSpecialityTypeCode VARCHAR(50),

/**
 * First choice speciality information.
 * id="firstChoiceSpecialityPanel"
 */
  firstChoiceSpecialityName     VARCHAR(50),
  firstChoiceSpecialityCode     VARCHAR(50),
  firstChoiceSpecialityTypeName VARCHAR(50),

/**
 * Exam Result.
 * id="examResultPanel"
 */
  politicalPoint                VARCHAR(50),
  zzcode                        VARCHAR(50),
  englishPoint                  VARCHAR(50),
  yycode                        VARCHAR(50),
  specialityOneName             VARCHAR(50),
  specialityOnePoint            VARCHAR(50),
  zyycode                       VARCHAR(50),
  specialityTwoName             VARCHAR(50),
  specialityTwoPoint            VARCHAR(50),
  zyecode                       VARCHAR(50),

/**
 * Bachelor information.
 * id="bachelorPanel"
 */
  graduateSchoolName            VARCHAR(50),
  graduateSpecialityName        VARCHAR(50),
  graduateSpecialityType        VARCHAR(50),
  graduateTime                  VARCHAR(50),
  bachelorType                  VARCHAR(50),
  getBachelorTime               VARCHAR(50),

/**
 * Speciality information.
 * id="specialityPanel"
 */
  adjustSpeciality              VARCHAR(50),
  adjustSpeciality2             VARCHAR(50),
  adjustSpeciality3             VARCHAR(50),
  allowChangeSpeciality         VARCHAR(50),
  ddllUnionTrainUnit            VARCHAR(50),
  ddllUnionTrainUnit2           VARCHAR(50),
  ddllUnionTrainUnit3           VARCHAR(50),

/**
 * Tracking information.
 */
  createTime                    VARCHAR(50),
  updateTime                    VARCHAR(50),

/**
 * Set the key and encoding.
 */
  PRIMARY KEY (identityNo, identity)

) ENGINE=InnoDB DEFAULT CHARSET=utf8 DEFAULT COLLATE=utf8_general_ci;


/**
 * Create table for news.
 */
CREATE TABLE IF NOT EXISTS news (

/**
 * Author information.
 */
  authorName                    VARCHAR(50),
  authorEmail                   VARCHAR(50),
  authorTelephone               VARCHAR(50),
/**
 * Artile information.
 */
  title                         VARCHAR(100),
  content                       TEXT,
/**
 * Tracking information.
 */
  createTime                    VARCHAR(50),
  updateTime                    VARCHAR(50),
/**
 * Set the primary key for the tabble.
 */
  PRIMARY KEY (title)

) ENGINE=InnoDB DEFAULT CHARSET=utf8 DEFAULT COLLATE=utf8_general_ci;


/**
 * Tracking information from back-end.
 * Applicants' status and scoring.
 */
CREATE TABLE IF NOT EXISTS application_info (

/*
 * Personal information.
 */
  identity                      VARCHAR(50),
  identityNo                    VARCHAR(50),
/*
 * wei shen he, zan huan, tong guo, ju jue
 */
  status                        VARCHAR(50),
/*
 * Information about second stage examination.
 */
  specialityOneName2nd          VARCHAR(50),
  specialityOnePoint2nd         VARCHAR(50),
  specialityTwoName2nd          VARCHAR(50),
  specialityTwoPoint2nd         VARCHAR(50),
  specialityThreeName2nd        VARCHAR(50),
  specialityThreePoint2nd       VARCHAR(50),
  specialityFourName2nd         VARCHAR(50),
  specialityFourPoint2nd        VARCHAR(50),
/*
 * Scores for interview and english listening.
 */
  interviewPoint                VARCHAR(50),
  listeningPoint                VARCHAR(50),

/**
 * Update time.
 */
  updateTime                    VARCHAR(50),

/**
* Set the key and encoding.
*/
  PRIMARY KEY (identityNo, identity)

) ENGINE=InnoDB DEFAULT CHARSET=utf8 DEFAULT COLLATE=utf8_general_ci;

/**
 * Cascade insertion into application after user information has been
 * inserted into register_info.
 */
DROP TRIGGER IF EXISTS init_application_info;

DELIMITER //

CREATE TRIGGER init_application_info
AFTER INSERT ON register_info
FOR EACH ROW
BEGIN
    insert into application_info(identity, identityNo, status, updateTime)
      values(new.identity, new.identityNo, "未审核", date_format(now(),'%Y-%c-%d %h:%i:%s'));
END;

DELIMITER ;
