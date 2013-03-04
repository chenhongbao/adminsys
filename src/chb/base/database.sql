
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
 * Set the key and encoding.
 */
  PRIMARY KEY (identityNo, identity)

) ENGINE=InnoDB DEFAULT CHARSET=utf8 DEFAULT COLLATE=utf8_general_ci;
