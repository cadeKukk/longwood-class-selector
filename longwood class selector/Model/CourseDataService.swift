import Foundation

// This class handles loading course data from Longwood University's catalog
class CourseDataService {
    
    // Get a sample of courses from various departments at Longwood
    static func getLongwoodCourses() -> [Course] {
        return [
            // Accounting courses
            createCourse(
                code: "ACCT 240",
                title: "Principles of Accounting I",
                instructor: "Dr. Bennie Waller",
                location: "Cormier Hall 102",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Introduction to financial accounting. Examines the accounting process, financial statements, and financial reporting standards for US and international businesses. Approaches accounting as an information system for meeting the demands for information.",
                prerequisites: [],
                department: "Accounting & Finance",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "ACCT 242",
                title: "Principles of Accounting II",
                instructor: "Dr. Frank Bacon",
                location: "Cormier Hall 104",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Continuation of ACCT 240. Introduces managerial accounting concepts for planning, control, and decision making. Focuses on product costing, budgeting, cost-volume-profit analysis, performance evaluation and ethics in a global context.",
                prerequisites: ["ACCT 240"],
                department: "Accounting & Finance",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "ACCT 340",
                title: "Intermediate Accounting I",
                instructor: "Dr. Haley Woznyj",
                location: "Cormier Hall 203",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Review of the accounting cycle; development of the theoretical foundation of financial reporting; accounting for assets; preparation and analysis of financial statements.",
                prerequisites: ["ACCT 242"],
                department: "Accounting & Finance",
                enrollment: 18,
                capacity: 25
            ),
            
            // Anthropology courses
            createCourse(
                code: "ANTH 101",
                title: "Introduction to Anthropology",
                instructor: "Dr. James Jordan",
                location: "Rotunda Hall 115",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "An introduction to the diversity of human behavior, social groups, and cultural systems throughout the world. The course explores anthropological concepts and methods, including ethnography, ethnohistory, and archaeology.",
                prerequisites: [],
                department: "Sociology & Anthropology",
                enrollment: 35,
                capacity: 40
            ),
            
            createCourse(
                code: "ANTH 296",
                title: "Field Methods in Archaeology",
                instructor: "Dr. Brian Bates",
                location: "Rotunda Hall 215",
                time: "1:00 PM - 4:50 PM",
                days: [.friday],
                credits: 6,
                description: "The field school provides a foundation in the methods and techniques of archaeology with an emphasis on excavation, recording, post-excavation analysis, and general field logistics.",
                prerequisites: ["ANTH 101"],
                department: "Sociology & Anthropology",
                enrollment: 10,
                capacity: 15
            ),
            
            // Art courses
            createCourse(
                code: "ART 120",
                title: "Foundations of Contemporary Design",
                instructor: "Dr. Kelly Nelson",
                location: "Bedford Hall 207",
                time: "1:00 PM - 3:30 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Understanding the basic principles, vocabulary, and visual elements of two-dimensional design through inquiry into the historical sources and terms of creative expression of art in the 20th and 21st centuries.",
                prerequisites: [],
                department: "Art",
                enrollment: 18,
                capacity: 20
            ),
            
            createCourse(
                code: "ART 270",
                title: "Painting: Acrylic & Oil",
                instructor: "Prof. Mara Scrupe",
                location: "Bedford Hall A111",
                time: "9:30 AM - 12:00 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Fundamentals of painting involved in subject matter, composition, and materials through the use of acrylics and oils. Investigation into backgrounds of contemporary painting.",
                prerequisites: ["ART 120", "ART 130"],
                department: "Art",
                enrollment: 12,
                capacity: 15
            ),
            
            // Biology courses
            createCourse(
                code: "BIOL 121",
                title: "The Unity of Life",
                instructor: "Dr. Mark Fink",
                location: "Chichester Science Center 107",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "The first of a two-semester introduction to biology for biology and health pre-professional majors. Major topics include the molecular and cellular basis of life, energy and life, photosynthesis and cellular respiration, classical and molecular genetics, and mechanisms of evolution.",
                prerequisites: [],
                department: "Biological & Environmental Sciences",
                enrollment: 40,
                capacity: 40,
                hasLab: true,
                labTime: "1:00 PM - 3:50 PM",
                labDays: [.wednesday],
                labLocation: "Chichester Science Center B104"
            ),
            
            createCourse(
                code: "BIOL 122",
                title: "The Diversity of Life",
                instructor: "Dr. Mary Lehman",
                location: "Chichester Science Center 211",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "The second of a two-semester introduction to biology for biology and health pre-professional majors. Major topics include eukaryotic cell structure and function, plant structure and function, animal structure and function, and ecology.",
                prerequisites: ["BIOL 121"],
                department: "Biological & Environmental Sciences",
                enrollment: 30,
                capacity: 35,
                hasLab: true,
                labTime: "9:00 AM - 11:50 AM",
                labDays: [.friday],
                labLocation: "Chichester Science Center B108"
            ),
            
            // Chemistry courses
            createCourse(
                code: "CHEM 101",
                title: "General Chemistry I",
                instructor: "Dr. Sarah Porter",
                location: "Chichester Science Center 305",
                time: "11:00 AM - 12:15 PM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "A study of the basic concepts of chemistry, including atomic structure, the periodic system, bonding, molecular geometry, nomenclature, stoichiometry, and chemical reactions, with emphasis on problem solving.",
                prerequisites: [],
                department: "Chemistry & Physics",
                enrollment: 28,
                capacity: 30,
                hasLab: true,
                labTime: "2:00 PM - 4:50 PM",
                labDays: [.thursday],
                labLocation: "Chichester Science Center C205"
            ),
            
            // Communication Studies courses
            createCourse(
                code: "COMM 200",
                title: "Fundamentals of Communication",
                instructor: "Dr. Jeff Halliday",
                location: "Bedford Hall 209",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Development of competencies in interpersonal relations, small group interaction, and public speaking. Emphasis on understanding and practicing the interpersonal and presentation skills basic to personal and professional life.",
                prerequisites: [],
                department: "Communication Studies",
                enrollment: 30,
                capacity: 30
            ),
            
            // Computer Science courses
            createCourse(
                code: "CMSC 140",
                title: "Introduction to Programming",
                instructor: "Dr. Julian Dymacek",
                location: "Rotunda 354",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "An introduction to computer programming. Emphasis on structured programming techniques, problem-solving, and algorithm development. Topics include computer history, architecture, ethics, variables, control structures, data types, functions, program testing.",
                prerequisites: [],
                department: "Computer Science",
                enrollment: 30,
                capacity: 30
            ),
            
            createCourse(
                code: "CMSC 208",
                title: "Grammars, Languages, and Automata",
                instructor: "Dr. Robert Marmorstein",
                location: "Rotunda 356",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "This course introduces formal languages, grammars, and automata, which form the theoretical foundation of computer science. Topics include context-free grammars, regular expressions, pushdown automata, Turing machines, computability, and the halting problem.",
                prerequisites: ["CMSC 140"],
                department: "Computer Science",
                enrollment: 18,
                capacity: 25
            ),
            
            // Economics courses
            createCourse(
                code: "ECON 217",
                title: "Principles of Economics (Micro Emphasis)",
                instructor: "Dr. David Lehr",
                location: "Cormier Hall 207",
                time: "1:00 PM - 1:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Overview of microeconomic and macroeconomic concepts. Microeconomic topics include markets, production, and price theory. Macroeconomic topics include national income accounting, inflation, unemployment, and money supply and demand.",
                prerequisites: [],
                department: "Economics & Finance",
                enrollment: 32,
                capacity: 35
            ),
            
            // Education courses
            createCourse(
                code: "EDUC 245",
                title: "Human Growth and Development",
                instructor: "Dr. Christopher Jones",
                location: "Hull Education Center 129",
                time: "12:30 PM - 1:45 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "A survey of human growth and development from conception through adolescence. Major theories of physical, cognitive, and psychosocial development are examined and applied to personal experiences and educational practice.",
                prerequisites: [],
                department: "Education & Counseling",
                enrollment: 26,
                capacity: 30
            ),
            
            // English courses
            createCourse(
                code: "ENGL 150",
                title: "Writing and Research",
                instructor: "Dr. Sean Barry",
                location: "Greenwood Library 209",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Writing and Research is designed to teach students how to use college-level critical thinking, reading, and writing to generate, explore, share, and test ideas through writing in academic, civic, and professional contexts.",
                prerequisites: [],
                department: "English & Modern Languages",
                enrollment: 20,
                capacity: 25
            ),
            
            createCourse(
                code: "ENGL 380",
                title: "Children's Literature",
                instructor: "Dr. Gena Southall",
                location: "Greenwood Library 147",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "A course designed to help students develop an understanding of excellent literature for children and gain competence in evaluating what makes exceptional children's literature. Students will read broadly from a variety of genres.",
                prerequisites: ["ENGL 150"],
                department: "English & Modern Languages",
                enrollment: 22,
                capacity: 25
            ),
            
            createCourse(
                code: "ENGL 209",
                title: "Introduction to Literary Analysis",
                instructor: "Dr. Sean Barry",
                location: "Greenwood Library 211",
                time: "11:00 AM - 11:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Introducing the English major, this course teaches students how to read and write critically about literature, using a variety of approaches and terminology. It provides instruction in literary analysis through interpretation and evaluation of literary texts and introduces the application of literary theory.",
                prerequisites: ["ENGL 150"],
                department: "English & Modern Languages",
                enrollment: 18,
                capacity: 25
            ),
            
            createCourse(
                code: "ENGL 325",
                title: "British Literature: Medieval to Renaissance",
                instructor: "Dr. Shawn Smith",
                location: "Greenwood Library 213",
                time: "1:00 PM - 1:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "A study of British literature from the Anglo-Saxon period to the Renaissance. Students will read major and minor works from key historical and cultural moments in this time period and explore how literary and artistic movements emerged in Britain.",
                prerequisites: ["ENGL 209"],
                department: "English & Modern Languages",
                enrollment: 15,
                capacity: 25
            ),
            
            createCourse(
                code: "ENGL 335",
                title: "American Literature: Colonial to Realism",
                instructor: "Dr. David Magill",
                location: "Greenwood Library 215",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "A study of American literature from the Colonial era to Realism. Focus on major literary movements and historical contexts, including colonization, the American Revolution, Romanticism, Transcendentalism, and the Civil War.",
                prerequisites: ["ENGL 209"],
                department: "English & Modern Languages",
                enrollment: 20,
                capacity: 25
            ),
            
            createCourse(
                code: "ENGL 470",
                title: "Professional Writing Skills",
                instructor: "Dr. Gena Southall",
                location: "Greenwood Library 145",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "A study of contemporary approaches to written communication in professional contexts. Emphasis will be placed on document design, visual rhetoric, and writing for a variety of professional contexts, including social media, business, technical, and digital writing.",
                prerequisites: ["ENGL 150"],
                department: "English & Modern Languages",
                enrollment: 22,
                capacity: 25
            ),
            
            // History courses
            createCourse(
                code: "HIST 150",
                title: "Historical Inquiry",
                instructor: "Dr. Steven Isaac",
                location: "Rotunda 215",
                time: "1:00 PM - 1:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "This course introduces students to the methods of historical inquiry and research and explores various topics related to the study of history. Provides background for upper-level courses in European, non-Western, US, and Virginia history.",
                prerequisites: [],
                department: "History, Political Science & Philosophy",
                enrollment: 40,
                capacity: 45
            ),
            
            createCourse(
                code: "HIST 221",
                title: "United States History Colonial-1877",
                instructor: "Dr. David Coles",
                location: "Rotunda Hall 215",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "A survey of American life from the Colonial Era to 1877, with emphasis upon political, social, economic, and cultural developments of the nation.",
                prerequisites: [],
                department: "History",
                enrollment: 24,
                capacity: 30
            ),
            
            createCourse(
                code: "HIST 222",
                title: "United States History 1877-Modern Times",
                instructor: "Dr. Steven Isaac",
                location: "Rotunda Hall 216",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "A survey of American life from 1877 to modern times, with emphasis upon the political, social, economic, and cultural developments of the nation.",
                prerequisites: [],
                department: "History",
                enrollment: 23,
                capacity: 30
            ),
            
            createCourse(
                code: "HIST 305",
                title: "Modern America, 1945-Present",
                instructor: "Dr. Larissa Fergeson",
                location: "Rotunda Hall 218",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "The history of America's political, social, economic, diplomatic, and cultural development from the end of World War II to the present.",
                prerequisites: ["HIST 222"],
                department: "History",
                enrollment: 18,
                capacity: 25
            ),
            
            createCourse(
                code: "HIST 362",
                title: "The Vietnam War",
                instructor: "Dr. David Coles",
                location: "Rotunda Hall 219",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "An examination of the background, events, and impact of America's longest war. The course emphasizes the political, military, diplomatic, and social dimensions of the conflict, and includes discussion of the war's legacy in American society, culture, politics, and foreign relations.",
                prerequisites: ["HIST 222"],
                department: "History, Political Science & Philosophy",
                enrollment: 28,
                capacity: 30
            ),
            
            createCourse(
                code: "HIST 370",
                title: "Virginia Studies",
                instructor: "Dr. Melissa Kravetz",
                location: "Rotunda Hall 219",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "A survey of Virginia's history, geography, government, economy, and people. Emphasis will be on how Virginia's experiences have contributed to national developments.",
                prerequisites: [],
                department: "History",
                enrollment: 20,
                capacity: 25
            ),
            
            // Mathematics courses  
            createCourse(
                code: "MATH 171",
                title: "Statistical Decision Making",
                instructor: "Dr. M. Leigh Lunsford",
                location: "Rotunda 328",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "An elementary statistics course designed to show the student how statistics is used in problem solving and decision making. Topics include descriptive statistics, measures of central tendency, probability, estimation, hypothesis testing, and regression.",
                prerequisites: [],
                department: "Mathematics & Computer Science",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "MATH 175",
                title: "Discrete Mathematics",
                instructor: "Dr. Sharon Emerson-Stonnell",
                location: "Rotunda 340",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 2,
                description: "An introduction to topics in discrete mathematics with an emphasis on applications to computer science. Topics include elementary number theory, counting, discrete probability, and graph theory.",
                prerequisites: [],
                department: "Mathematics & Computer Science",
                enrollment: 22,
                capacity: 30
            ),
            
            createCourse(
                code: "MATH 261",
                title: "The Differential and Integral Calculus I",
                instructor: "Dr. David Shoenthal",
                location: "Rotunda 330",
                time: "11:00 AM - 11:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "The first course in the three-course calculus sequence for mathematics, science, and education majors. Topics include limits, continuity, differentiability, derivatives, applications of derivatives, the definite integral, and the Fundamental Theorem of Calculus.",
                prerequisites: ["MATH 164"],
                department: "Mathematics & Computer Science",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "MATH 262",
                title: "The Differential and Integral Calculus II",
                instructor: "Dr. M. Leigh Lunsford",
                location: "Rotunda 332",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Continuation of MATH 261. Topics include the calculus of inverse functions, techniques of integration, improper integrals, applications of integration, sequences, and power series representations of functions.",
                prerequisites: ["MATH 261"],
                department: "Mathematics & Computer Science",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "MATH 300",
                title: "A Transition to Advanced Mathematics",
                instructor: "Dr. David Shoenthal",
                location: "Rotunda 334",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "An introduction to rigorous mathematical proof with focus on the properties of natural numbers, integers, rational numbers, and real numbers. Topics include elementary set theory, functions, and relations.",
                prerequisites: ["MATH 175", "MATH 261"],
                department: "Mathematics & Computer Science",
                enrollment: 18,
                capacity: 25
            ),
            
            createCourse(
                code: "MATH 350",
                title: "Differential Equations",
                instructor: "Dr. Virginia Lewis",
                location: "Rotunda 336",
                time: "1:00 PM - 1:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "A study of ordinary differential equations of the first and second order, linear differential equations of higher order, and applications to physics, chemistry, engineering, biology, and the social sciences.",
                prerequisites: ["MATH 262"],
                department: "Mathematics & Computer Science",
                enrollment: 15,
                capacity: 25
            ),
            
            // Music courses
            createCourse(
                code: "MUSC 225",
                title: "Introduction to World Music",
                instructor: "Dr. Charles Kinzer",
                location: "Wygal Hall 106",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Survey of the history of world music from the perspective of geographic regions, trends, styles, and genres. Focus on cultural implications, historical significance, and value of music in global societies and their impact on society.",
                prerequisites: [],
                department: "Music",
                enrollment: 20,
                capacity: 25
            ),
            
            // Nursing courses
            createCourse(
                code: "NURS 210",
                title: "Health Assessment Across the Lifespan",
                instructor: "Dr. Deborah Ulmer",
                location: "Stevens Science Center a203",
                time: "2:30 PM - 3:45 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Introduces the student to the health assessment process with a focus on holistic assessment. The role of the professional nurse in comprehensive physical assessment and history-taking skills is emphasized.",
                prerequisites: ["BIOL 206", "BIOL 207"],
                department: "Nursing",
                enrollment: 24,
                capacity: 25
            ),
            
            createCourse(
                code: "NURS 230",
                title: "Foundations of Nursing Practice",
                instructor: "Dr. Lisa Minor",
                location: "Stevens Science Center 205",
                time: "10:00 AM - 11:15 AM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "This introductory course focuses on fundamental nursing principles and the development of clinical judgment in providing nursing care. The nursing process is utilized to address client care situations in a variety of clinical and community settings.",
                prerequisites: ["NURS 210"],
                department: "Nursing",
                enrollment: 22,
                capacity: 24
            ),
            
            createCourse(
                code: "NURS 340",
                title: "Pharmacology and Pathophysiology",
                instructor: "Dr. Hadley Sporbert",
                location: "Stevens Science Center 207",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "This course examines pathophysiology and the pharmacological aspects of client care. The focus is on understanding disease processes and corresponding drug classification, actions, therapeutic effects, side effects, and nursing implications.",
                prerequisites: ["NURS 230"],
                department: "Nursing",
                enrollment: 20,
                capacity: 24
            ),
            
            createCourse(
                code: "NURS 410",
                title: "Nursing Care of Patients with Complex Health Problems",
                instructor: "Dr. Cynthia Snow",
                location: "Stevens Science Center 209",
                time: "9:00 AM - 10:15 AM",
                days: [.tuesday, .thursday],
                credits: 5,
                description: "This course focuses on the application of critical thinking and the nursing process for patients with complex health problems. Emphasis is placed on the nurse's role in planning, implementing, and evaluating care for adult patients with multisystem disorders.",
                prerequisites: ["NURS 340"],
                department: "Nursing",
                enrollment: 18,
                capacity: 20
            ),
            
            // Philosophy courses
            createCourse(
                code: "PHIL 200",
                title: "Introduction to Philosophy",
                instructor: "Dr. Eric Moore",
                location: "Rotunda Hall 116",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "A critical examination of some of the basic problems of philosophy. Topics to be studied include theories of knowledge and reality, freedom and determinism, morality and ethics, church and state, democracy, and God's existence.",
                prerequisites: [],
                department: "History, Political Science & Philosophy",
                enrollment: 25,
                capacity: 30
            ),
            
            // Physics courses
            createCourse(
                code: "PHYS 101",
                title: "General Physics I",
                instructor: "Dr. Timothy Holmstrom",
                location: "Chichester Science Center 301",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "An introduction to the basic concepts of mechanics, including vectors, kinematics, Newton's laws, friction, work-energy theorem, impulse-momentum theorem, conservation of energy, and rotational dynamics.",
                prerequisites: ["MATH 261"],
                department: "Chemistry & Physics",
                enrollment: 20,
                capacity: 24
            ),
            
            // Political Science courses
            createCourse(
                code: "POSC 150",
                title: "American Government and Politics",
                instructor: "Dr. N. Scott Cole",
                location: "Rotunda Hall 116",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "An introduction to the American political system, with an emphasis on the national government. The course focuses on constitutional foundations, the political actors, and the processes of decision-making.",
                prerequisites: [],
                department: "Political Science",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "POSC 331",
                title: "Political Philosophy",
                instructor: "Dr. William Harbour",
                location: "Rotunda Hall 234",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "A survey of the principal political theories and philosophies from ancient Greece through the Middle Ages, including the contributions of Plato, Aristotle, Cicero, St. Augustine, and St. Thomas Aquinas.",
                prerequisites: ["POSC 150"],
                department: "History, Political Science & Philosophy",
                enrollment: 20,
                capacity: 25
            ),
            
            createCourse(
                code: "POSC 343",
                title: "American Foreign Policy",
                instructor: "Dr. Scott Cole",
                location: "Rotunda Hall 236",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "A study of the factors and forces that determine American foreign policy. Emphasis on the historical evolution of U.S. foreign policy, its continuity and change, and the role of internal and external factors in shaping U.S. foreign policy from the founding of the Republic to the present.",
                prerequisites: ["POSC 150"],
                department: "History, Political Science & Philosophy",
                enrollment: 22,
                capacity: 25
            ),
            
            // Psychology courses
            createCourse(
                code: "PSYC 101",
                title: "Introduction to Psychology",
                instructor: "Dr. Stephanie Buchert",
                location: "Rotunda Hall 234",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "An overview of the scientific study of behavior and mental processes, addressing the biological, social, and cognitive foundations of psychology, research methods, consciousness, learning, memory, and psychological disorders.",
                prerequisites: [],
                department: "Psychology",
                enrollment: 38,
                capacity: 40
            ),
            
            createCourse(
                code: "PSYC 233",
                title: "Research Methods in Psychology",
                instructor: "Dr. Catherine Franssen",
                location: "Rotunda 323",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "Examines the empirical nature of psychology. Provides students with practice in the design, conduct, analysis, interpretation, and reporting of psychological research. Supervised laboratory experience.",
                prerequisites: ["PSYC 101"],
                department: "Psychology",
                enrollment: 22,
                capacity: 24
            ),
            
            createCourse(
                code: "PSYC 234",
                title: "Quantitative Methods in Psychology",
                instructor: "Dr. Sarai Blincoe",
                location: "Rotunda Hall 236",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Introduction to the principles and techniques of experimental design and statistical analysis. Covers descriptive and inferential statistical techniques with an emphasis on research methods in psychology.",
                prerequisites: ["PSYC 101"],
                department: "Psychology",
                enrollment: 24,
                capacity: 25
            ),
            
            // Sociology courses
            createCourse(
                code: "SOCL 101",
                title: "Principles of Sociology",
                instructor: "Dr. Jason Milne",
                location: "Rotunda Hall 226",
                time: "11:00 AM - 11:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "An introduction to the scientific study of human social behavior. The sociological perspective, social structure and interaction, social groups, deviance, stratification, social institutions, social change, and global diversity.",
                prerequisites: [],
                department: "Sociology & Anthropology",
                enrollment: 35,
                capacity: 40
            ),
            
            // Theatre courses
            createCourse(
                code: "THEA 101",
                title: "Introduction to Theatre",
                instructor: "Dr. Bruce Speas",
                location: "Rotunda Hall 118",
                time: "1:00 PM - 1:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "A survey of all aspects of theatre and its role in society, from antiquity to the present. Emphasis is on the development of theatre arts in the Western world. Students will gain practical experience in production activities.",
                prerequisites: [],
                department: "Theatre",
                enrollment: 20,
                capacity: 25
            ),
            
            // Add courses from the Liberal Studies program
            createCourse(
                code: "LSTU 250",
                title: "Introduction to Liberal Studies",
                instructor: "Dr. Melissa Rhoten",
                location: "Rotunda Hall a227",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "This course introduces students to the Liberal Studies major and to interdisciplinary approaches to addressing complex issues. The focus is on a topic that spans multiple disciplines, as experienced through different disciplinary approaches and methods.",
                prerequisites: [],
                department: "Liberal Studies",
                enrollment: 15,
                capacity: 20
            ),
            
            // Kinesiology courses
            createCourse(
                code: "KINS 205",
                title: "Introduction to Exercise Science",
                instructor: "Dr. Jo Morrison",
                location: "Health & Fitness Center 206",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "This course examines the fundamental concepts of exercise science including kinesiology, exercise physiology, and biomechanics. Students will gain an understanding of the scientific background for the structure and function of the human body related to exercise and sport.",
                prerequisites: [],
                department: "Health, Athletic Training, Recreation & Kinesiology",
                enrollment: 28,
                capacity: 32
            ),
            
            // Business Administration courses
            createCourse(
                code: "MANG 360",
                title: "Principles of Management",
                instructor: "Dr. William Holliday",
                location: "Cormier Hall 213",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Management fundamentals with emphasis on theories of management, the evolution of management thought, and the functions of management in organizational activity. Particular attention is given to planning, organizing, directing, and controlling.",
                prerequisites: ["ACCT 240"],
                department: "Management & Marketing",
                enrollment: 33,
                capacity: 40
            ),
            
            // Marketing courses
            createCourse(
                code: "MARK 380",
                title: "Principles of Marketing",
                instructor: "Dr. Melanie Marks",
                location: "Cormier Hall 215",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "An introduction to the concepts, analyses, and activities that comprise marketing management including practice in making marketing decisions. Topics include understanding the consumer and industrial buying process, developing customer relationships, and formulating marketing strategy.",
                prerequisites: [],
                department: "Management & Marketing",
                enrollment: 28,
                capacity: 35
            ),
            
            // Additional Computer Science Courses
            createCourse(
                code: "CMSC 160",
                title: "Introduction to Algorithmic Design I",
                instructor: "Dr. Julian Dymacek",
                location: "Rotunda 354",
                time: "11:00 AM - 12:15 PM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "An introduction to problem solving and algorithmic design using an object-oriented programming language. Topics include programming logic, iteration, functions, recursion, arrays, memory management, user-defined data types, abstraction, and complexity analysis.",
                prerequisites: [],
                department: "Computer Science",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "CMSC 162",
                title: "Introduction to Algorithmic Design II",
                instructor: "Dr. Robert Marmorstein",
                location: "Rotunda 356",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "A continuation of CMSC 160. Topics include algorithmic design, complexity analysis, abstract data types, and encapsulation and basic data structures. Advanced topics using a modern high-level programming language inheritance, overloading, and use of objects.",
                prerequisites: ["CMSC 160"],
                department: "Computer Science",
                enrollment: 20,
                capacity: 30
            ),
            
            createCourse(
                code: "CMSC 201",
                title: "Computer Organization",
                instructor: "Dr. Mariko Shimizu",
                location: "Rotunda 358",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "The organization, design, and structure of computer systems, including both hardware and software principles. Topics include memory addressing, machine-level representations of software and data, fundamentals of logic design, and the mechanics of information transfer and control within a computer system.",
                prerequisites: ["CMSC 160"],
                department: "Computer Science",
                enrollment: 15,
                capacity: 25
            ),
            
            createCourse(
                code: "CMSC 389",
                title: "Artificial Intelligence",
                instructor: "Dr. Julian Dymacek",
                location: "Rotunda 350",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "A programming intensive course covering the theory and techniques of artificial intelligence (AI) with implementations using both statistical and nonstatistical AI methods. Covered topics will span the central AI problems of planning, learning, and reasoning.",
                prerequisites: ["CMSC 262"],
                department: "Computer Science",
                enrollment: 12,
                capacity: 20
            ),
            
            createCourse(
                code: "CMSC 442",
                title: "Operating Systems",
                instructor: "Dr. Robert Marmorstein",
                location: "Rotunda 356",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "A programming-intensive course in which students learn the important data structures and algorithms of an operating system and apply them to the implementation of core O.S. components. Particular focus will be given to problems that arise in the presence of concurrency in both implementation of the operating system and application of programming.",
                prerequisites: ["CMSC 201", "CMSC 242"],
                department: "Computer Science",
                enrollment: 18,
                capacity: 20
            ),
            
            createCourse(
                code: "CMSC 455",
                title: "Network Security and Cryptography",
                instructor: "Dr. Mariko Shimizu",
                location: "Rotunda 362",
                time: "1:00 PM - 1:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "This course covers several modern cryptographic systems, including the DES and AES encryption standards. Their applications to network security are discussed, along with issues of authentication, privacy, intruders, malicious programs and firewalls.",
                prerequisites: ["CMSC 160", "MATH 175"],
                department: "Computer Science",
                enrollment: 15,
                capacity: 25
            ),
            
            createCourse(
                code: "CMSC 461",
                title: "Senior Capstone in Computer Science",
                instructor: "Dr. Julian Dymacek",
                location: "Rotunda 354",
                time: "3:30 PM - 4:45 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "A capstone course designed to consolidate experiences from a variety of other courses by working in groups on one or more large projects. Principles of software engineering will be covered, including traditional and object-oriented software design, software lifecycle models, software analysis, and management implications.",
                prerequisites: ["CMSC 208", "CMSC 262"],
                department: "Computer Science",
                enrollment: 10,
                capacity: 15
            ),
            
            // Business Administration Courses
            createCourse(
                code: "MANG 363",
                title: "Operations Management",
                instructor: "Dr. John Gaskins",
                location: "Cormier Hall 217",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Applied management focusing on operations within organizations including planning, decision, and control functions. Topics include forecasting, break-even analysis, inventory management, project management, and scheduling.",
                prerequisites: ["MANG 360"],
                department: "Management & Marketing",
                enrollment: 28,
                capacity: 35
            ),
            
            createCourse(
                code: "MANG 391",
                title: "Professional Skills Development",
                instructor: "Dr. Melanie Marks",
                location: "Cormier Hall 215",
                time: "2:00 PM - 3:15 PM",
                days: [.monday, .wednesday],
                credits: 2,
                description: "This course is designed to develop professional skills necessary for successful integration into the contemporary workplace. Topics include professional etiquette, interpersonal and cross-cultural skills, career planning, self-marketing, job search skills, developing resumes, writing effective business communications, and interviewing.",
                prerequisites: [],
                department: "Management & Marketing",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "MANG 474",
                title: "Managing Business Ethics",
                instructor: "Dr. Charles White",
                location: "Cormier Hall 210",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "This course provides a comprehensive study of the ethical issues involving business management. Appropriate ethical issues will be analyzed and related to current events. Special emphasis will be placed on the ethical perspectives of decision-making.",
                prerequisites: ["MANG 360"],
                department: "Management & Marketing",
                enrollment: 22,
                capacity: 30
            ),
            
            createCourse(
                code: "FINA 350",
                title: "Principles of Finance",
                instructor: "Dr. Frank Bacon",
                location: "Cormier Hall 202",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Principles and practices of financial management within a business firm. Examines acquisition of funds, cash flow, financial analysis, capital budgeting, working capital requirements, and capital structure.",
                prerequisites: ["ACCT 240", "ECON 217"],
                department: "Accounting & Finance",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "FINA 451",
                title: "Investment Analysis and Portfolio Management",
                instructor: "Dr. Bennie Waller",
                location: "Cormier Hall 204",
                time: "1:00 PM - 1:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Characteristics and analysis of individual securities as well as the theory and practice of optimally combining securities into portfolios. The presentation of material is intended to be rigorous and practical, without being overly quantitative.",
                prerequisites: ["FINA 350"],
                department: "Accounting & Finance",
                enrollment: 20,
                capacity: 25
            ),
            
            createCourse(
                code: "FINA 453",
                title: "Principles of Real Estate",
                instructor: "Dr. Bennie Waller",
                location: "Cormier Hall 204",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "Principles of ownership and transfer of real property interests; buying, selling, or leasing residential or investment real estate; and legal, economic, financial, and appraisal aspects of the subject matter.",
                prerequisites: ["FINA 350"],
                department: "Accounting & Finance",
                enrollment: 18,
                capacity: 24
            ),
            
            // Psychology Courses
            createCourse(
                code: "PSYC 356",
                title: "Abnormal Psychology",
                instructor: "Dr. Jennifer Apperson",
                location: "Rotunda 327",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "This course provides a comprehensive survey of mental disorders with an emphasis on clinical description and diagnosis, etiology and pathogenesis, and evidence-based treatments. Emphasis will be placed on understanding mental disorders from both theoretical and scientific perspectives.",
                prerequisites: ["PSYC 101"],
                department: "Psychology",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "PSYC 384",
                title: "Cross-Cultural Psychology",
                instructor: "Dr. David Carkenord",
                location: "Rotunda 329",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "An in-depth investigation of the relationships between cultural and human development, and the thoughts, emotions and behaviors of individuals in different cultures. Focus will be given to research methodology and findings from diverse cultural viewpoints.",
                prerequisites: ["PSYC 101"],
                department: "Psychology",
                enrollment: 25,
                capacity: 30
            ),
            
            // Communication Studies Courses
            createCourse(
                code: "COMM 310",
                title: "Interpersonal Communication",
                instructor: "Dr. Naomi Johnson",
                location: "Bedford Hall 203",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "This course explores the structure and function of interpersonal communication and focuses on improving communication skills in a variety of interpersonal contexts. Topics include communication processes, perception, language, nonverbal communication, listening, conflict management, and relational contexts.",
                prerequisites: ["COMM 200"],
                department: "Communication Studies",
                enrollment: 20,
                capacity: 25
            ),
            
            createCourse(
                code: "COMM 400",
                title: "Communication Ethics",
                instructor: "Dr. Jeff Halliday",
                location: "Bedford Hall 205",
                time: "1:00 PM - 1:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "This course explores the ethical issues pertaining to communication in a variety of contexts. Students will learn to discern a wide variety of ethical dilemmas, and to evaluate appropriate actions using a systematic framework of ethical decision-making.",
                prerequisites: ["COMM 200"],
                department: "Communication Studies",
                enrollment: 15,
                capacity: 20
            ),
            
            // Education Courses
            createCourse(
                code: "EDUC 380",
                title: "Classroom Assessment",
                instructor: "Dr. Stephen Keith",
                location: "Hull Education Center 140",
                time: "2:00 PM - 3:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Theory and practice in the construction, administration, and interpretation of appropriate classroom assessments based on best practices for PreK-12 classrooms. Focus will include student assessment, teacher self-assessment, and data collection for planning instruction.",
                prerequisites: ["EDUC 245"],
                department: "Education & Counseling",
                enrollment: 22,
                capacity: 24
            ),
            
            createCourse(
                code: "EDUC 487",
                title: "Classroom Management and System Issues",
                instructor: "Dr. Christopher Jones",
                location: "Hull Education Center 132",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "An examination of classroom management techniques and the development of skills necessary to foster a supportive learning environment as well as examination of system problems and solutions within traditional education settings N, K-12.",
                prerequisites: ["EDUC 380"],
                department: "Education & Counseling",
                enrollment: 18,
                capacity: 24
            ),
            
            // Kinesiology Courses
            createCourse(
                code: "KINS 350",
                title: "Sport and Exercise Psychology",
                instructor: "Dr. Joanna Morrison",
                location: "Health & Fitness Center 210",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "An examination of the psychological aspects of sport and exercise. Concepts to be explored include personality, motivation, anxiety, stress, and self-confidence. Topics include goal-setting, imagery, peak performance and concentration.",
                prerequisites: ["KINS 205"],
                department: "Health, Athletic Training, Recreation & Kinesiology",
                enrollment: 22,
                capacity: 25
            ),
            
            createCourse(
                code: "KINS 387",
                title: "Physiology of Exercise",
                instructor: "Dr. Laura Jimenez",
                location: "Health & Fitness Center 212",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "Lecture and laboratory experiences in the physiological responses of the body to the physical activity in everyday life and in sports. Includes cardiovascular, respiratory, metabolic, and muscular responses and adaptations to both acute and chronic physical activity.",
                prerequisites: ["KINS 205"],
                department: "Health, Athletic Training, Recreation & Kinesiology",
                enrollment: 24,
                capacity: 24
            ),
            
            // Biology Courses
            createCourse(
                code: "BIOL 250",
                title: "Introduction to Genetics and Cell Biology",
                instructor: "Dr. Mark Fink",
                location: "Chichester Science Center 109",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "This course introduces the major principles and concepts related to genetics and cell biology. Topics include Mendelian and non-Mendelian genetics, molecular genetics, gene expression, cell structure and function, membrane transport, cell signaling, and the cell cycle.",
                prerequisites: ["BIOL 121", "BIOL 122"],
                department: "Biological & Environmental Sciences",
                enrollment: 30,
                capacity: 32
            ),
            
            createCourse(
                code: "BIOL 341",
                title: "Ecology",
                instructor: "Dr. Mary Lehman",
                location: "Chichester Science Center 212",
                time: "10:00 AM - 11:15 AM",
                days: [.monday, .wednesday],
                credits: 4,
                description: "A study of relationships between organisms and their environment. Basic ecological principles of populations, communities, and ecosystems will be explored with an emphasis on field techniques and applications relevant to ecosystem management and conservation biology.",
                prerequisites: ["BIOL 122"],
                department: "Biological & Environmental Sciences",
                enrollment: 22,
                capacity: 24
            ),
            
            createCourse(
                code: "BIOL 474",
                title: "Immunology",
                instructor: "Dr. Amorette Barber",
                location: "Chichester Science Center 214",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "A study of the molecular and cellular processes of immune system function. Topics include innate and adaptive immunity, cellular interactions, antibody structure and function, immunopathology, and applications of immunological techniques in medicine and biological research.",
                prerequisites: ["BIOL 250"],
                department: "Biological & Environmental Sciences",
                enrollment: 16,
                capacity: 20
            ),
            
            // Additional Computer Science Courses from Longwood Catalog
            createCourse(
                code: "CMSC 121",
                title: "Introduction to Computer Science",
                instructor: "Dr. Julian Dymacek",
                location: "Rotunda 352",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "An introduction to computer science for non-specialists. Basic computer architecture and design, storage formats, principles of computer operation, and algorithms. Application software that emphasizes the computer as a tool.",
                prerequisites: [],
                department: "Computer Science",
                enrollment: 28,
                capacity: 35
            ),
            
            createCourse(
                code: "CMSC 210",
                title: "Web Page Design and Scripting",
                instructor: "Dr. Robert Marmorstein",
                location: "Rotunda 360",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "The class will study interactive web pages that provide customized data in response to visitor requests and/or collect data from site visitors. This interaction will be done via program scripts written in an appropriate language.",
                prerequisites: ["CMSC 140"],
                department: "Computer Science",
                enrollment: 20,
                capacity: 25
            ),
            
            createCourse(
                code: "CMSC 240",
                title: "Linux Systems Administration",
                instructor: "Dr. Mariko Shimizu",
                location: "Rotunda 364",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "A hands-on approach to use and administration of the Linux-based operating systems. Emphasizes file systems, process management, account management, software patching and maintenance, text manipulation, and the use of scripts to automate administrative tasks.",
                prerequisites: ["CMSC 162"],
                department: "Computer Science",
                enrollment: 18,
                capacity: 24
            ),
            
            createCourse(
                code: "CMSC 280",
                title: "Programming in a Second Language",
                instructor: "Dr. Julian Dymacek",
                location: "Rotunda 354",
                time: "1:00 PM - 1:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "A programming-intensive course that gives students a comprehensive introduction to a language not taught in the introductory sequence. Examples of languages which may be taught are Ada, Fortran, and Java.",
                prerequisites: ["CMSC 160"],
                department: "Computer Science",
                enrollment: 15,
                capacity: 25
            ),
            
            createCourse(
                code: "CMSC 355",
                title: "Introduction to Computer and Network Security",
                instructor: "Dr. Mariko Shimizu",
                location: "Rotunda 358",
                time: "3:30 PM - 4:45 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "A course dealing with basic techniques in computer and network security. Topics covered include elementary cryptography, secure programs, malicious code, protection of operating systems, database security, network security, and security administration.",
                prerequisites: ["CMSC 140"],
                department: "Computer Science",
                enrollment: 15,
                capacity: 22
            ),
            
            createCourse(
                code: "CMSC 362",
                title: "Theory of Databases",
                instructor: "Dr. Robert Marmorstein",
                location: "Rotunda 356",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "A course covering the theory and practice of modern databases design and implementation. Topics include relational and hierarchical database design, database query languages, update consistency, and distributed databases.",
                prerequisites: ["CMSC 262"],
                department: "Computer Science",
                enrollment: 12,
                capacity: 20
            ),
            
            createCourse(
                code: "CMSC 381",
                title: "Introduction to Graphics Programming",
                instructor: "Dr. Julian Dymacek",
                location: "Rotunda 354",
                time: "2:30 PM - 3:45 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "This course is designed to introduce students to computer graphics programming techniques. It will combine the use of a high-level programming language with a publicly available graphics application programming interface. Other topics will include the mathematics to manipulate geometric objects.",
                prerequisites: ["CMSC 162"],
                department: "Computer Science",
                enrollment: 10,
                capacity: 18
            ),
            
            createCourse(
                code: "CMSC 387",
                title: "Introduction to Machine Learning",
                instructor: "Dr. Julian Dymacek",
                location: "Rotunda 352",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "An introduction to basic concepts in machine learning. Students will be introduced to the fundamental concepts and algorithms used by computers to solve real world problems. Topics include supervised learning, unsupervised learning, deep learning, and reinforcement learning.",
                prerequisites: ["CMSC 262", "MATH 171"],
                department: "Computer Science",
                enrollment: 14,
                capacity: 20
            ),
            
            createCourse(
                code: "CMSC 415",
                title: "Theory of Computation",
                instructor: "Dr. Robert Marmorstein",
                location: "Rotunda 356",
                time: "1:00 PM - 2:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Continues to develop the theoretical frameworks introduced in CMSC 208 such as language and automata theory, and the computability of functions. Topics include complexity analysis through reductions, NP-completeness, hierarchy of languages, and the Church-Turing thesis.",
                prerequisites: ["CMSC 208"],
                department: "Computer Science",
                enrollment: 8,
                capacity: 15
            ),
            
            createCourse(
                code: "CMSC 420",
                title: "Graph Theory",
                instructor: "Dr. Julian Dymacek",
                location: "Rotunda 360",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "An introduction to topics in graph theory, focusing on analysis of specific applications and proofs of important theorems in the discipline. Topics include graphs, paths, and cycles; directed graphs, trees, and applications of graph theory in real world contexts.",
                prerequisites: ["CMSC 160", "MATH 300"],
                department: "Computer Science",
                enrollment: 8,
                capacity: 15
            ),
            
            createCourse(
                code: "CMSC 445",
                title: "Compiler Design",
                instructor: "Dr. Robert Marmorstein",
                location: "Rotunda 356",
                time: "3:30 PM - 4:45 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "A course covering the basic theory and techniques of compiler and code translation systems. Topics include lexical analysis, parsing, and code generation, and the various techniques used when handling differing source language classes. Also covered are the techniques of top-down and bottom-up parsing.",
                prerequisites: ["CMSC 201", "CMSC 208"],
                department: "Computer Science",
                enrollment: 6,
                capacity: 15
            ),
            
            // Additional Business Administration Courses
            createCourse(
                code: "BUSN 110",
                title: "Business Bootcamp: Student Success in CBE and Beyond",
                instructor: "Dr. Melanie Marks",
                location: "Cormier Hall 101",
                time: "10:00 AM - 10:50 AM",
                days: [.friday],
                credits: 1,
                description: "An introduction to the College of Business and Economics that introduces students to campus resources, provides opportunities to connect with faculty, staff, student organizations, and other students, and provides skill-building for student success.",
                prerequisites: [],
                department: "Business Administration",
                enrollment: 40,
                capacity: 50
            ),
            
            createCourse(
                code: "BUSN 296",
                title: "Legal Environment",
                instructor: "Dr. Ernest O'Boyle",
                location: "Cormier Hall 206",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "A survey of the critical business law requirements that are needed for day-to-day business operations. Topics include the legal concepts surrounding the creation of business entities, corporate governance, securities law, and employment law.",
                prerequisites: [],
                department: "Business Administration",
                enrollment: 35,
                capacity: 40
            ),
            
            createCourse(
                code: "MANG 291",
                title: "Business Communication",
                instructor: "Dr. William Holliday",
                location: "Cormier Hall 214",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Principles, practices, and techniques of electronic and written communication in business. Emphasis on writing business messages, reports, and various types of professional business documents.",
                prerequisites: [],
                department: "Management & Marketing",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "MANG 364",
                title: "Negotiations and Conflict Management",
                instructor: "Dr. John Gaskins",
                location: "Cormier Hall 219",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "This course explores the dynamics of interpersonal and intergroup conflict and resolution. Students will learn to analyze conflicts that occur in business, understand the dynamics of interpersonal and intergroup communication, and identify and practice effective communication strategies.",
                prerequisites: ["MANG 360"],
                department: "Management & Marketing",
                enrollment: 22,
                capacity: 28
            ),
            
            createCourse(
                code: "MANG 385",
                title: "Supply Chain Management",
                instructor: "Dr. Charles White",
                location: "Cormier Hall 215",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of supply chain management from a managerial perspective. Topics include strategies, information systems in supply chain, inventory management, performance metrics, and integration and collaboration.",
                prerequisites: ["MANG 363"],
                department: "Management & Marketing",
                enrollment: 18,
                capacity: 25
            ),
            
            createCourse(
                code: "MANG 463",
                title: "Project Management",
                instructor: "Dr. John Gaskins",
                location: "Cormier Hall 219",
                time: "3:30 PM - 4:45 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Concepts and techniques of managing projects including project definition, project selection, project planning, resource scheduling and project scheduling, monitoring and controlling, and closure.",
                prerequisites: ["MANG 363"],
                department: "Management & Marketing",
                enrollment: 15,
                capacity: 25
            ),
            
            createCourse(
                code: "MANG 469",
                title: "Entrepreneurship",
                instructor: "Dr. William Holliday",
                location: "Cormier Hall 216",
                time: "11:00 AM - 12:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "An introduction to entrepreneurship concepts and practical implementation. Topics will include developing entrepreneurial ideas, creating a business plan, sources of financing, location analysis, and small business management and operations.",
                prerequisites: ["MANG 360"],
                department: "Management & Marketing",
                enrollment: 20,
                capacity: 25
            ),
            
            createCourse(
                code: "MANG 497",
                title: "Business Strategy",
                instructor: "Dr. Charles White",
                location: "Cormier Hall 218",
                time: "1:00 PM - 2:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Integrative study of the managerial decision-making process. Examined from the perspective of the integration of strategic analysis, leadership, stakeholder theory, social responsibility, business ethics, and external influences on organizations operating in the global environment.",
                prerequisites: ["FINA 350", "MANG 360", "MARK 380"],
                department: "Management & Marketing",
                enrollment: 25,
                capacity: 30
            ),
            
            // Marketing Courses
            createCourse(
                code: "MARK 481",
                title: "International Business",
                instructor: "Dr. Melanie Marks",
                location: "Cormier Hall 220",
                time: "2:00 PM - 3:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "A study of successful business practices in the global marketplace. Areas of coverage include international trade theory, comparative and competitive advantage, importing, exporting, trade barriers, foreign investments, multinational firms, and the economic dynamics of global competition.",
                prerequisites: ["MARK 380"],
                department: "Management & Marketing",
                enrollment: 20,
                capacity: 25
            ),
            
            createCourse(
                code: "MARK 482",
                title: "Marketing Strategy",
                instructor: "Dr. Melanie Marks",
                location: "Cormier Hall 222",
                time: "3:30 PM - 4:45 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "An application-focused study of marketing strategy in today's complex and dynamic market environment. Focus is on formulating and implementing marketing strategies that are consistent with an organization's resources and capabilities.",
                prerequisites: ["MARK 380"],
                department: "Management & Marketing",
                enrollment: 18,
                capacity: 25
            ),
            
            // Philosophy Courses
            createCourse(
                code: "PHIL 417",
                title: "Business Ethics",
                instructor: "Dr. Eric Moore",
                location: "Rotunda Hall 118",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "A study of ethical theories and their applications to business issues. This course examines basic economic and moral concepts underlying business relations between employers and employees, business and consumers, and businesses and the environment.",
                prerequisites: ["PHIL 200"],
                department: "History, Political Science & Philosophy",
                enrollment: 25,
                capacity: 30
            ),
            
            // Chemistry Courses
            createCourse(
                code: "CHEM 102",
                title: "General Chemistry II",
                instructor: "Dr. Sarah Porter",
                location: "Chichester Science Center 307",
                time: "10:00 AM - 11:15 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Continuation of CHEM 101. Topics include solution chemistry, acid-base chemistry, chemical equilibrium, kinetics, thermodynamics, electrochemistry, nuclear chemistry, and an introduction to organic chemistry.",
                prerequisites: ["CHEM 101"],
                department: "Chemistry & Physics",
                enrollment: 24,
                capacity: 30
            ),
            
            createCourse(
                code: "CHEM 305",
                title: "Organic Chemistry I",
                instructor: "Dr. Andrew Yeagley",
                location: "Chichester Science Center 309",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "First semester of a two-semester course in organic chemistry. Topics include bonding, structure, reaction mechanisms, nomenclature, stereochemistry, and synthesis of aliphatic and aromatic compounds.",
                prerequisites: ["CHEM 102"],
                department: "Chemistry & Physics",
                enrollment: 20,
                capacity: 24
            ),
            
            // Physics Courses
            createCourse(
                code: "PHYS 102",
                title: "General Physics II",
                instructor: "Dr. Timothy Holmstrom",
                location: "Chichester Science Center 303",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "A continuation of PHYS 101. Topics include electricity, magnetism, electromagnetic waves, optics, and modern physics.",
                prerequisites: ["PHYS 101"],
                department: "Chemistry & Physics",
                enrollment: 18,
                capacity: 24,
                hasLab: true,
                labTime: "1:00 PM - 3:50 PM",
                labDays: [.monday],
                labLocation: "Chichester Science Center C301"
            ),
            
            createCourse(
                code: "PHYS 303",
                title: "Astrophysics",
                instructor: "Dr. Timothy Holmstrom",
                location: "Chichester Science Center 305",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "A detailed study of the physics of the universe. Topics include stellar structure and evolution, galactic dynamics, cosmology, and the formation of planets and solar systems.",
                prerequisites: ["PHYS 101", "PHYS 102"],
                department: "Chemistry & Physics",
                enrollment: 12,
                capacity: 20
            ),
            
            // Modern Languages Courses
            createCourse(
                code: "SPAN 201",
                title: "Intermediate Spanish I",
                instructor: "Dr. Isabel Morales",
                location: "Grainger Hall 104",
                time: "11:00 AM - 11:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "A course designed to help students develop increased proficiency in Spanish in the four language skills (listening, speaking, reading, and writing). Special emphasis is placed on cultural and literary readings and conversational skills.",
                prerequisites: [],
                department: "English & Modern Languages",
                enrollment: 20,
                capacity: 25
            ),
            
            createCourse(
                code: "SPAN 202",
                title: "Intermediate Spanish II",
                instructor: "Dr. Isabel Morales",
                location: "Grainger Hall 104",
                time: "1:00 PM - 1:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "A continuation of SPAN 201 with stronger emphasis on reading, writing, and cultural competence.",
                prerequisites: ["SPAN 201"],
                department: "English & Modern Languages",
                enrollment: 18,
                capacity: 25
            ),
            
            createCourse(
                code: "FREN 201",
                title: "Intermediate French I",
                instructor: "Dr. Heather Edwards",
                location: "Grainger Hall 106",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "A course designed to give intensive practice in speaking and writing French based on a variety of cultural topics. The course includes a comprehensive grammar review and reading assignments.",
                prerequisites: [],
                department: "English & Modern Languages",
                enrollment: 15,
                capacity: 25
            ),
            
            createCourse(
                code: "FREN 202",
                title: "Intermediate French II",
                instructor: "Dr. Heather Edwards",
                location: "Grainger Hall 106",
                time: "2:00 PM - 2:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "A continuation of FREN 201 with an increased emphasis on reading, writing, and cultural competence.",
                prerequisites: ["FREN 201"],
                department: "English & Modern Languages",
                enrollment: 12,
                capacity: 25
            ),
            
            createCourse(
                code: "ART 110",
                title: "Crafts",
                instructor: "Prof. Kerri Cushman",
                location: "Bedford Hall A109",
                time: "9:00 AM - 11:30 AM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "An understanding of the basic principles and techniques of traditional and contemporary crafts. Emphasis on studio projects with special consideration given to craft forms that apply to K-12 art instruction.",
                prerequisites: [],
                department: "Art",
                enrollment: 15,
                capacity: 18
            ),
            
            createCourse(
                code: "ART 130",
                title: "Drawing I",
                instructor: "Prof. Mara Scrupe",
                location: "Bedford Hall A107",
                time: "1:00 PM - 3:30 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "An introduction to the fundamentals of drawing, including the language of art, the use of various drawing media, and the use of the formal elements in creating art.",
                prerequisites: [],
                department: "Art",
                enrollment: 18,
                capacity: 20
            ),
            
            createCourse(
                code: "ART 250",
                title: "Printmaking I",
                instructor: "Prof. Kelly Nelson",
                location: "Bedford Hall B101",
                time: "9:30 AM - 12:00 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "An introduction to a variety of printmaking processes, including relief, intaglio, and planographic techniques. Historical and cultural connections to printmaking will be explored.",
                prerequisites: ["ART 120", "ART 130"],
                department: "Art",
                enrollment: 14,
                capacity: 16
            ),
            
            createCourse(
                code: "ART 360",
                title: "Women in the Visual Arts",
                instructor: "Dr. Alison Coles",
                location: "Bedford Hall 204",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "This course examines the contributions of women to the history of Western art from the ancient world to the present. It also introduces gender theories in art history and feminist art criticism.",
                prerequisites: [],
                department: "Art",
                enrollment: 20,
                capacity: 25
            ),
            
            // Additional Business Courses
            createCourse(
                code: "BUSI 200",
                title: "Introduction to Business",
                instructor: "Dr. Michael Thompson",
                location: "Cormier Hall 105",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "An introduction to the world of business including management, marketing, finance, accounting, economics, and business law. Emphasis on the role of business in society and ethical decision making.",
                prerequisites: [],
                department: "Business",
                enrollment: 35,
                capacity: 40
            ),
            
            createCourse(
                code: "BUSI 310",
                title: "Organizational Behavior",
                instructor: "Dr. Jennifer Walsh",
                location: "Cormier Hall 201",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of individual and group behavior in organizations. Topics include motivation, leadership, communication, decision making, conflict resolution, and organizational culture.",
                prerequisites: ["BUSI 200"],
                department: "Business",
                enrollment: 28,
                capacity: 35
            ),
            
            createCourse(
                code: "MKTG 300",
                title: "Principles of Marketing",
                instructor: "Dr. Robert Chen",
                location: "Cormier Hall 108",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Introduction to marketing concepts and practices. Topics include market research, consumer behavior, product development, pricing, promotion, and distribution strategies.",
                prerequisites: ["BUSI 200"],
                department: "Business",
                enrollment: 32,
                capacity: 40
            ),
            
            // Criminal Justice Courses
            createCourse(
                code: "CRIM 101",
                title: "Introduction to Criminal Justice",
                instructor: "Dr. Patricia Williams",
                location: "Rotunda Hall 201",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "An overview of the criminal justice system including law enforcement, courts, and corrections. Examination of crime causation theories and current issues in criminal justice.",
                prerequisites: [],
                department: "Criminal Justice",
                enrollment: 45,
                capacity: 50
            ),
            
            createCourse(
                code: "CRIM 205",
                title: "Criminology",
                instructor: "Dr. Marcus Johnson",
                location: "Rotunda Hall 203",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of crime as a social phenomenon. Examination of theories of crime causation, types of crime, and crime prevention strategies.",
                prerequisites: ["CRIM 101"],
                department: "Criminal Justice",
                enrollment: 38,
                capacity: 45
            ),
            
            createCourse(
                code: "CRIM 310",
                title: "Police and Society",
                instructor: "Dr. Sarah Martinez",
                location: "Rotunda Hall 205",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Examination of the role of police in society, police organization and administration, police discretion, community policing, and police accountability.",
                prerequisites: ["CRIM 101"],
                department: "Criminal Justice",
                enrollment: 30,
                capacity: 35
            ),
            
            // Education Courses
            createCourse(
                code: "EDUC 200",
                title: "Foundations of Education",
                instructor: "Dr. Linda Davis",
                location: "Hull Education Center 125",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Introduction to the teaching profession including historical, philosophical, and sociological foundations of education. Field experience required.",
                prerequisites: [],
                department: "Education",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "EDUC 300",
                title: "Educational Psychology",
                instructor: "Dr. Michael Brown",
                location: "Hull Education Center 127",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Application of psychological principles to teaching and learning. Topics include cognitive development, learning theories, motivation, and assessment.",
                prerequisites: ["EDUC 200", "PSYC 101"],
                department: "Education",
                enrollment: 22,
                capacity: 28
            ),
            
            createCourse(
                code: "EDUC 410",
                title: "Classroom Management",
                instructor: "Dr. Rebecca Taylor",
                location: "Hull Education Center 130",
                time: "10:00 AM - 11:15 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Strategies for creating positive learning environments. Topics include behavior management, classroom organization, and building relationships with students.",
                prerequisites: ["EDUC 300"],
                department: "Education",
                enrollment: 20,
                capacity: 25
            ),
            
            // Geography Courses
            createCourse(
                code: "GEOG 101",
                title: "World Regional Geography",
                instructor: "Dr. James Anderson",
                location: "Rotunda Hall 301",
                time: "11:00 AM - 11:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Survey of world regions with emphasis on physical and cultural characteristics, economic development, and environmental issues.",
                prerequisites: [],
                department: "Geography",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "GEOG 205",
                title: "Physical Geography",
                instructor: "Dr. Susan Clark",
                location: "Rotunda Hall 303",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of Earth's physical systems including climate, landforms, soils, and vegetation. Emphasis on human-environment interactions.",
                prerequisites: [],
                department: "Geography",
                enrollment: 25,
                capacity: 30
            ),
            
            // Health & Physical Education Courses
            createCourse(
                code: "HLTH 101",
                title: "Personal Health",
                instructor: "Dr. Karen Wilson",
                location: "Lancer Gym 201",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Comprehensive study of personal health including nutrition, exercise, stress management, substance abuse prevention, and disease prevention.",
                prerequisites: [],
                department: "Health & Physical Education",
                enrollment: 40,
                capacity: 45
            ),
            
            createCourse(
                code: "PHED 150",
                title: "Fitness and Wellness",
                instructor: "Prof. David Miller",
                location: "Lancer Gym 105",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 1,
                description: "Introduction to physical fitness concepts and wellness practices. Includes fitness assessment, exercise prescription, and lifestyle modification.",
                prerequisites: [],
                department: "Health & Physical Education",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "PHED 250",
                title: "Exercise Physiology",
                instructor: "Dr. Lisa Rodriguez",
                location: "Lancer Gym 203",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of physiological responses and adaptations to exercise. Topics include cardiovascular, respiratory, and metabolic responses to physical activity.",
                prerequisites: ["BIOL 121", "HLTH 101"],
                department: "Health & Physical Education",
                enrollment: 20,
                capacity: 25
            ),
            
            // Liberal Studies Courses
            createCourse(
                code: "LBST 100",
                title: "Citizen Leader",
                instructor: "Dr. Amanda Foster",
                location: "Grainger Hall 201",
                time: "2:00 PM - 2:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Introduction to liberal education and civic engagement. Development of critical thinking, communication, and leadership skills.",
                prerequisites: [],
                department: "Liberal Studies",
                enrollment: 22,
                capacity: 25
            ),
            
            createCourse(
                code: "LBST 250",
                title: "Global Perspectives",
                instructor: "Dr. Thomas Lee",
                location: "Grainger Hall 203",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Examination of global issues from multiple perspectives. Topics include cultural diversity, international relations, and global citizenship.",
                prerequisites: ["LBST 100"],
                department: "Liberal Studies",
                enrollment: 28,
                capacity: 30
            ),
            
            // Music Courses
            createCourse(
                code: "MUSC 101",
                title: "Music Appreciation",
                instructor: "Dr. Catherine Moore",
                location: "Wygal Music Building 101",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Introduction to music through listening, analysis, and historical study. Survey of musical styles from various periods and cultures.",
                prerequisites: [],
                department: "Music",
                enrollment: 35,
                capacity: 40
            ),
            
            createCourse(
                code: "MUSC 120",
                title: "Music Theory I",
                instructor: "Dr. Robert Harrison",
                location: "Wygal Music Building 103",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Fundamentals of music theory including scales, intervals, chords, and basic harmonic progressions. Includes ear training and sight-singing.",
                prerequisites: [],
                department: "Music",
                enrollment: 18,
                capacity: 20
            ),
            
            createCourse(
                code: "MUSC 200",
                title: "Applied Music: Piano",
                instructor: "Prof. Jennifer Adams",
                location: "Wygal Music Building 205",
                time: "2:00 PM - 2:50 PM",
                days: [.tuesday, .thursday],
                credits: 2,
                description: "Individual piano instruction for students at intermediate level. Emphasis on technique, repertoire, and performance skills.",
                prerequisites: ["MUSC 120"],
                department: "Music",
                enrollment: 8,
                capacity: 10
            ),
            
            // Nursing Courses
            createCourse(
                code: "NURS 101",
                title: "Foundations of Nursing",
                instructor: "Dr. Mary Johnson",
                location: "Health Sciences Building 201",
                time: "8:00 AM - 9:15 AM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "Introduction to professional nursing practice. Topics include nursing history, ethics, communication, and basic nursing skills.",
                prerequisites: ["BIOL 121", "BIOL 122"],
                department: "Nursing",
                enrollment: 30,
                capacity: 32,
                hasLab: true,
                labTime: "1:00 PM - 4:50 PM",
                labDays: [.friday],
                labLocation: "Health Sciences Building Lab A"
            ),
            
            createCourse(
                code: "NURS 205",
                title: "Pharmacology for Nurses",
                instructor: "Dr. Patricia White",
                location: "Health Sciences Building 203",
                time: "10:00 AM - 11:15 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of pharmacological principles and drug therapy. Emphasis on safe medication administration and patient education.",
                prerequisites: ["NURS 101", "CHEM 101"],
                department: "Nursing",
                enrollment: 28,
                capacity: 30
            ),
            
            // Philosophy Courses
            createCourse(
                code: "PHIL 101",
                title: "Introduction to Philosophy",
                instructor: "Dr. William Turner",
                location: "Grainger Hall 301",
                time: "1:00 PM - 1:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Introduction to major philosophical questions and methods. Topics include knowledge, reality, ethics, and the meaning of life.",
                prerequisites: [],
                department: "Philosophy",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "PHIL 205",
                title: "Ethics",
                instructor: "Dr. Sarah Green",
                location: "Grainger Hall 303",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of moral philosophy including major ethical theories and their application to contemporary moral issues.",
                prerequisites: [],
                department: "Philosophy",
                enrollment: 22,
                capacity: 25
            ),
            
            // Political Science Courses
            createCourse(
                code: "POLS 101",
                title: "American Government",
                instructor: "Dr. Richard Stone",
                location: "Grainger Hall 205",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Study of American political institutions, processes, and policies. Topics include the Constitution, federalism, civil liberties, and political participation.",
                prerequisites: [],
                department: "Political Science",
                enrollment: 40,
                capacity: 45
            ),
            
            createCourse(
                code: "POLS 205",
                title: "International Relations",
                instructor: "Dr. Maria Santos",
                location: "Grainger Hall 207",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Introduction to international politics including state behavior, international organizations, conflict and cooperation, and global issues.",
                prerequisites: [],
                department: "Political Science",
                enrollment: 30,
                capacity: 35
            ),
            
            // Recreation & Leisure Studies Courses
            createCourse(
                code: "RECR 101",
                title: "Introduction to Recreation",
                instructor: "Dr. Kevin Thompson",
                location: "Lancer Gym 301",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Overview of recreation and leisure services including history, philosophy, and career opportunities in various settings.",
                prerequisites: [],
                department: "Recreation & Leisure Studies",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "RECR 250",
                title: "Outdoor Recreation",
                instructor: "Prof. Jessica Parker",
                location: "Lancer Gym 303",
                time: "1:00 PM - 3:30 PM",
                days: [.wednesday],
                credits: 3,
                description: "Study of outdoor recreation activities and their management. Includes hands-on experience with outdoor skills and environmental education.",
                prerequisites: ["RECR 101"],
                department: "Recreation & Leisure Studies",
                enrollment: 18,
                capacity: 20
            ),
            
            // Social Work Courses
            createCourse(
                code: "SOCW 101",
                title: "Introduction to Social Work",
                instructor: "Dr. Angela Davis",
                location: "Rotunda Hall 401",
                time: "11:00 AM - 11:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Overview of social work profession including values, ethics, and practice methods. Introduction to social welfare systems and social justice issues.",
                prerequisites: [],
                department: "Social Work",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "SOCW 205",
                title: "Human Behavior and Social Environment",
                instructor: "Dr. Mark Wilson",
                location: "Rotunda Hall 403",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of human development across the lifespan and the impact of social, cultural, and environmental factors on behavior.",
                prerequisites: ["SOCW 101", "PSYC 101"],
                department: "Social Work",
                enrollment: 25,
                capacity: 30
            ),
            
            // Theatre Courses
            createCourse(
                code: "THEA 101",
                title: "Introduction to Theatre",
                instructor: "Dr. Jennifer Black",
                location: "Jarman Auditorium 101",
                time: "2:00 PM - 2:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Survey of theatre arts including history, dramatic literature, and production elements. Attendance at live performances required.",
                prerequisites: [],
                department: "Theatre",
                enrollment: 28,
                capacity: 35
            ),
            
            createCourse(
                code: "THEA 150",
                title: "Acting I",
                instructor: "Prof. Michael Roberts",
                location: "Jarman Auditorium Studio",
                time: "6:00 PM - 8:30 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Introduction to basic acting techniques including voice, movement, and character development. Emphasis on scene work and improvisation.",
                prerequisites: [],
                department: "Theatre",
                enrollment: 15,
                capacity: 18
            ),
            
            // Additional Mathematics Courses
            createCourse(
                code: "MATH 165",
                title: "Calculus II",
                instructor: "Dr. Jennifer Walsh",
                location: "Rotunda Hall 356",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Continuation of MATH 161. Topics include techniques of integration, applications of integration, infinite sequences and series, and parametric equations.",
                prerequisites: ["MATH 161"],
                department: "Mathematics",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "MATH 265",
                title: "Calculus III",
                instructor: "Dr. Robert Chen",
                location: "Rotunda Hall 358",
                time: "11:00 AM - 11:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Multivariable calculus including partial derivatives, multiple integrals, vector calculus, and applications to physics and engineering.",
                prerequisites: ["MATH 165"],
                department: "Mathematics",
                enrollment: 20,
                capacity: 25
            ),
            
            createCourse(
                code: "MATH 310",
                title: "Linear Algebra",
                instructor: "Dr. Sarah Kim",
                location: "Rotunda Hall 360",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of vector spaces, linear transformations, matrices, determinants, eigenvalues, and eigenvectors with applications.",
                prerequisites: ["MATH 165"],
                department: "Mathematics",
                enrollment: 18,
                capacity: 22
            ),
            
            // Additional English Courses
            createCourse(
                code: "ENGL 200",
                title: "Introduction to Literature",
                instructor: "Dr. Elizabeth Harper",
                location: "Grainger Hall 105",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Introduction to the study of literature through reading and analysis of poetry, fiction, and drama from various periods and cultures.",
                prerequisites: ["ENGL 101"],
                department: "English & Modern Languages",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "ENGL 250",
                title: "Creative Writing",
                instructor: "Prof. David Martinez",
                location: "Grainger Hall 107",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Workshop course in creative writing including fiction, poetry, and creative nonfiction. Emphasis on developing individual voice and style.",
                prerequisites: ["ENGL 101"],
                department: "English & Modern Languages",
                enrollment: 18,
                capacity: 20
            ),
            
            createCourse(
                code: "ENGL 350",
                title: "American Literature",
                instructor: "Dr. Patricia Johnson",
                location: "Grainger Hall 109",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Survey of American literature from colonial period to present. Emphasis on major authors and literary movements.",
                prerequisites: ["ENGL 200"],
                department: "English & Modern Languages",
                enrollment: 22,
                capacity: 25
            ),
            
            // Business Administration Courses
            createCourse(
                code: "BUSN 201",
                title: "Introduction to Business",
                instructor: "Dr. Michael Thompson",
                location: "Cormier Hall 305",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Survey of business operations including management, marketing, finance, and entrepreneurship in the global economy.",
                prerequisites: [],
                department: "Business Administration",
                enrollment: 35,
                capacity: 40
            ),
            
            createCourse(
                code: "BUSN 300",
                title: "Operations Management",
                instructor: "Dr. Lisa Chen",
                location: "Cormier Hall 307",
                time: "1:00 PM - 2:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Analysis of production and service operations including planning, scheduling, quality control, and supply chain management.",
                prerequisites: ["BUSN 201", "MATH 155"],
                department: "Business Administration",
                enrollment: 28,
                capacity: 30
            ),
            
            createCourse(
                code: "BUSN 350",
                title: "Strategic Management",
                instructor: "Dr. Robert Davis",
                location: "Cormier Hall 309",
                time: "3:30 PM - 4:45 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Capstone course integrating business functions through case analysis and strategic planning. Emphasis on decision-making in competitive environments.",
                prerequisites: ["BUSN 300", "MKTG 301", "FINC 301"],
                department: "Business Administration",
                enrollment: 20,
                capacity: 25
            ),
            
            // Criminal Justice Courses
            createCourse(
                code: "CRJU 101",
                title: "Introduction to Criminal Justice",
                instructor: "Dr. Sarah Williams",
                location: "Rotunda Hall 205",
                time: "11:00 AM - 11:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Overview of the criminal justice system including law enforcement, courts, and corrections. Examination of crime causation and prevention.",
                prerequisites: [],
                department: "Criminal Justice",
                enrollment: 45,
                capacity: 50
            ),
            
            createCourse(
                code: "CRJU 250",
                title: "Criminal Law",
                instructor: "Dr. James Rodriguez",
                location: "Rotunda Hall 207",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of substantive criminal law including elements of crimes, defenses, and constitutional principles affecting criminal liability.",
                prerequisites: ["CRJU 101"],
                department: "Criminal Justice",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "CRJU 300",
                title: "Criminology",
                instructor: "Dr. Maria Garcia",
                location: "Rotunda Hall 209",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Theoretical explanations of criminal behavior including biological, psychological, and sociological perspectives on crime causation.",
                prerequisites: ["CRJU 101", "SOCI 101"],
                department: "Criminal Justice",
                enrollment: 35,
                capacity: 40
            ),
            
            // Education Courses
            createCourse(
                code: "EDUC 200",
                title: "Introduction to Teaching",
                instructor: "Dr. Jennifer Brown",
                location: "Stevens Hall 101",
                time: "8:00 AM - 9:15 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Introduction to the teaching profession including educational philosophy, classroom management, and instructional strategies.",
                prerequisites: [],
                department: "Education",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "EDUC 250",
                title: "Educational Psychology",
                instructor: "Dr. David Miller",
                location: "Stevens Hall 103",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Application of psychological principles to educational settings including learning theories, motivation, and assessment.",
                prerequisites: ["PSYC 101", "EDUC 200"],
                department: "Education",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "EDUC 300",
                title: "Curriculum and Instruction",
                instructor: "Dr. Susan Taylor",
                location: "Stevens Hall 105",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Principles of curriculum development and instructional design. Emphasis on lesson planning, assessment, and differentiated instruction.",
                prerequisites: ["EDUC 250"],
                department: "Education",
                enrollment: 22,
                capacity: 25
            ),
            
            // Health Sciences Courses
            createCourse(
                code: "HLTH 101",
                title: "Personal Health",
                instructor: "Dr. Karen Johnson",
                location: "Lancer Park 201",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Comprehensive approach to personal health including nutrition, fitness, stress management, and disease prevention.",
                prerequisites: [],
                department: "Health Sciences",
                enrollment: 40,
                capacity: 45
            ),
            
            createCourse(
                code: "HLTH 220",
                title: "Community Health",
                instructor: "Dr. Mark Anderson",
                location: "Lancer Park 203",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of community health issues including epidemiology, health promotion, and public health policy.",
                prerequisites: ["HLTH 101"],
                department: "Health Sciences",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "HLTH 350",
                title: "Health Program Planning",
                instructor: "Dr. Lisa White",
                location: "Lancer Park 205",
                time: "2:00 PM - 3:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Planning, implementation, and evaluation of health education programs in various community settings.",
                prerequisites: ["HLTH 220", "STAT 250"],
                department: "Health Sciences",
                enrollment: 25,
                capacity: 28
            ),
            
            // History Courses
            createCourse(
                code: "HIST 101",
                title: "World History I",
                instructor: "Dr. Thomas Lee",
                location: "Grainger Hall 201",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Survey of world civilizations from ancient times to 1500 CE, emphasizing cultural, political, and economic developments.",
                prerequisites: [],
                department: "History",
                enrollment: 40,
                capacity: 45
            ),
            
            createCourse(
                code: "HIST 102",
                title: "World History II",
                instructor: "Dr. Rachel Green",
                location: "Grainger Hall 203",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Survey of world civilizations from 1500 to present, focusing on globalization, imperialism, and modern conflicts.",
                prerequisites: [],
                department: "History",
                enrollment: 35,
                capacity: 40
            ),
            
            createCourse(
                code: "HIST 201",
                title: "United States History I",
                instructor: "Dr. William Clark",
                location: "Grainger Hall 205",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Survey of American history from colonial period through Civil War, emphasizing political, social, and economic development.",
                prerequisites: [],
                department: "History",
                enrollment: 38,
                capacity: 42
            ),
            
            createCourse(
                code: "HIST 202",
                title: "United States History II",
                instructor: "Dr. Nancy Adams",
                location: "Grainger Hall 207",
                time: "11:00 AM - 11:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Survey of American history from Reconstruction to present, focusing on industrialization, social movements, and foreign policy.",
                prerequisites: [],
                department: "History",
                enrollment: 42,
                capacity: 45
            ),
            
            // Kinesiology Courses
            createCourse(
                code: "KINE 101",
                title: "Introduction to Kinesiology",
                instructor: "Dr. Steve Parker",
                location: "Lancer Park 301",
                time: "8:00 AM - 8:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Overview of kinesiology including exercise physiology, biomechanics, motor learning, and career opportunities in health and fitness.",
                prerequisites: [],
                department: "Kinesiology",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "KINE 210",
                title: "Exercise Physiology",
                instructor: "Dr. Michelle Roberts",
                location: "Lancer Park 303",
                time: "10:00 AM - 11:15 AM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "Study of physiological responses and adaptations to exercise including cardiovascular, respiratory, and metabolic systems.",
                prerequisites: ["KINE 101", "BIOL 121"],
                department: "Kinesiology",
                enrollment: 25,
                capacity: 28,
                hasLab: true,
                labTime: "2:00 PM - 4:50 PM",
                labDays: [.friday],
                labLocation: "Lancer Park Exercise Lab"
            ),
            
            createCourse(
                code: "KINE 300",
                title: "Biomechanics",
                instructor: "Dr. Brian Wilson",
                location: "Lancer Park 305",
                time: "1:00 PM - 2:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Application of mechanical principles to human movement including kinematics, kinetics, and movement analysis.",
                prerequisites: ["KINE 101", "PHYS 121", "MATH 155"],
                department: "Kinesiology",
                enrollment: 20,
                capacity: 24
            ),
            
            // Liberal Studies Courses
            createCourse(
                code: "LIBS 150",
                title: "Critical Thinking",
                instructor: "Dr. Amanda Foster",
                location: "Rotunda Hall 301",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Development of analytical and critical thinking skills including logic, argumentation, and problem-solving techniques.",
                prerequisites: [],
                department: "Liberal Studies",
                enrollment: 35,
                capacity: 40
            ),
            
            createCourse(
                code: "LIBS 200",
                title: "Global Connections",
                instructor: "Dr. Carlos Martinez",
                location: "Rotunda Hall 303",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Interdisciplinary exploration of global issues including culture, politics, economics, and environmental challenges.",
                prerequisites: ["LIBS 150"],
                department: "Liberal Studies",
                enrollment: 30,
                capacity: 35
            ),
            
            // Music Courses
            createCourse(
                code: "MUSC 101",
                title: "Music Fundamentals",
                instructor: "Dr. Patricia Evans",
                location: "Wygal Hall 101",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Basic elements of music including notation, scales, intervals, chords, and rhythm. Designed for non-music majors.",
                prerequisites: [],
                department: "Music",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "MUSC 111",
                title: "Music Theory I",
                instructor: "Dr. John Harrison",
                location: "Wygal Hall 103",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Comprehensive study of tonal harmony including scales, intervals, triads, seventh chords, and voice leading.",
                prerequisites: [],
                department: "Music",
                enrollment: 18,
                capacity: 20
            ),
            
            createCourse(
                code: "MUSC 131",
                title: "Concert Choir",
                instructor: "Dr. Sarah Mitchell",
                location: "Wygal Hall Choral Room",
                time: "3:00 PM - 4:15 PM",
                days: [.monday, .wednesday, .friday],
                credits: 1,
                description: "Large choral ensemble performing varied repertoire from classical to contemporary. Open to all students by audition.",
                prerequisites: [],
                department: "Music",
                enrollment: 45,
                capacity: 60
            ),
            
            createCourse(
                code: "MUSC 210",
                title: "Applied Piano",
                instructor: "Prof. Daniel Kim",
                location: "Wygal Hall Piano Studio",
                time: "TBA",
                days: [.tuesday, .thursday],
                credits: 2,
                description: "Individual piano instruction for students of all levels. Weekly private lessons with emphasis on technique and repertoire.",
                prerequisites: [],
                department: "Music",
                enrollment: 12,
                capacity: 15
            ),
            
            // Additional Psychology Courses
            createCourse(
                code: "PSYC 200",
                title: "Research Methods in Psychology",
                instructor: "Dr. Jennifer Stone",
                location: "Stevens Hall 201",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "Introduction to research methodology in psychology including experimental design, data collection, and statistical analysis.",
                prerequisites: ["PSYC 101", "MATH 155"],
                department: "Psychology",
                enrollment: 30,
                capacity: 32,
                hasLab: true,
                labTime: "1:00 PM - 2:50 PM",
                labDays: [.wednesday],
                labLocation: "Stevens Hall Psychology Lab"
            ),
            
            createCourse(
                code: "PSYC 240",
                title: "Developmental Psychology",
                instructor: "Dr. Mary Phillips",
                location: "Stevens Hall 203",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of human development across the lifespan including physical, cognitive, and socioemotional changes.",
                prerequisites: ["PSYC 101"],
                department: "Psychology",
                enrollment: 35,
                capacity: 40
            ),
            
            createCourse(
                code: "PSYC 250",
                title: "Social Psychology",
                instructor: "Dr. Robert Turner",
                location: "Stevens Hall 205",
                time: "1:00 PM - 2:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Study of individual behavior in social contexts including attitudes, conformity, group dynamics, and interpersonal relationships.",
                prerequisites: ["PSYC 101"],
                department: "Psychology",
                enrollment: 32,
                capacity: 35
            ),
            
            createCourse(
                code: "PSYC 310",
                title: "Abnormal Psychology",
                instructor: "Dr. Linda Carter",
                location: "Stevens Hall 207",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of psychological disorders including classification, etiology, and treatment approaches. Emphasis on current research and clinical applications.",
                prerequisites: ["PSYC 101", "PSYC 200"],
                department: "Psychology",
                enrollment: 28,
                capacity: 30
            ),
            
            // Modern Languages Courses
            createCourse(
                code: "SPAN 101",
                title: "Elementary Spanish I",
                instructor: "Dr. Isabel Rodriguez",
                location: "Grainger Hall 301",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Introduction to Spanish language and culture with emphasis on speaking, listening, reading, and writing skills.",
                prerequisites: [],
                department: "English & Modern Languages",
                enrollment: 22,
                capacity: 25
            ),
            
            createCourse(
                code: "SPAN 102",
                title: "Elementary Spanish II",
                instructor: "Dr. Miguel Santos",
                location: "Grainger Hall 303",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Continuation of SPAN 101. Further development of Spanish language skills with increased emphasis on conversation and cultural understanding.",
                prerequisites: ["SPAN 101"],
                department: "English & Modern Languages",
                enrollment: 20,
                capacity: 25
            ),
            
            createCourse(
                code: "FREN 101",
                title: "Elementary French I",
                instructor: "Dr. Marie Dubois",
                location: "Grainger Hall 305",
                time: "11:00 AM - 11:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Introduction to French language and francophone cultures with emphasis on fundamental communication skills.",
                prerequisites: [],
                department: "English & Modern Languages",
                enrollment: 18,
                capacity: 20
            ),
            
            // Philosophy Courses
            createCourse(
                code: "PHIL 101",
                title: "Introduction to Philosophy",
                instructor: "Dr. James Russell",
                location: "Rotunda Hall 401",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Introduction to major philosophical questions and methods including ethics, metaphysics, epistemology, and logic.",
                prerequisites: [],
                department: "Philosophy & Religious Studies",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "PHIL 201",
                title: "Ethics",
                instructor: "Dr. Catherine Moore",
                location: "Rotunda Hall 403",
                time: "10:00 AM - 11:15 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of moral philosophy including major ethical theories and their application to contemporary moral issues.",
                prerequisites: ["PHIL 101"],
                department: "Philosophy & Religious Studies",
                enrollment: 25,
                capacity: 30
            ),
            
            // Additional Computer Science Courses
            createCourse(
                code: "CMSC 150",
                title: "Computer Science I",
                instructor: "Dr. Andrew Chang",
                location: "Rotunda 350",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "Introduction to programming using object-oriented design. Topics include algorithms, data structures, and software engineering principles.",
                prerequisites: ["CMSC 140"],
                department: "Computer Science",
                enrollment: 25,
                capacity: 28,
                hasLab: true,
                labTime: "3:00 PM - 4:50 PM",
                labDays: [.friday],
                labLocation: "Rotunda Computer Lab"
            ),
            
            createCourse(
                code: "CMSC 250",
                title: "Computer Science II",
                instructor: "Dr. Sarah Wong",
                location: "Rotunda 352",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "Advanced programming concepts including data structures, algorithms, recursion, and object-oriented programming.",
                prerequisites: ["CMSC 150"],
                department: "Computer Science",
                enrollment: 22,
                capacity: 25,
                hasLab: true,
                labTime: "2:00 PM - 3:50 PM",
                labDays: [.monday],
                labLocation: "Rotunda Computer Lab"
            ),
            
            createCourse(
                code: "CMSC 300",
                title: "Database Systems",
                instructor: "Dr. Kevin Park",
                location: "Rotunda 354",
                time: "11:00 AM - 12:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Design and implementation of database systems including relational model, SQL, normalization, and database administration.",
                prerequisites: ["CMSC 250"],
                department: "Computer Science",
                enrollment: 20,
                capacity: 24
            ),
            
            createCourse(
                code: "CMSC 350",
                title: "Web Development",
                instructor: "Dr. Lisa Zhang",
                location: "Rotunda 356",
                time: "2:00 PM - 3:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Full-stack web development including HTML, CSS, JavaScript, server-side programming, and modern web frameworks.",
                prerequisites: ["CMSC 250"],
                department: "Computer Science",
                enrollment: 18,
                capacity: 22
            ),
            
            // Additional Science Courses
            createCourse(
                code: "PHYS 121",
                title: "General Physics I",
                instructor: "Dr. David Thompson",
                location: "Chichester Science Center 401",
                time: "8:00 AM - 9:15 AM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "Calculus-based physics covering mechanics, waves, and thermodynamics with emphasis on problem-solving and laboratory work.",
                prerequisites: ["MATH 161"],
                department: "Chemistry & Physics",
                enrollment: 25,
                capacity: 28,
                hasLab: true,
                labTime: "1:00 PM - 3:50 PM",
                labDays: [.wednesday],
                labLocation: "Chichester Physics Lab"
            ),
            
            createCourse(
                code: "PHYS 122",
                title: "General Physics II",
                instructor: "Dr. Emily Watson",
                location: "Chichester Science Center 403",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 4,
                description: "Continuation of PHYS 121 covering electricity, magnetism, optics, and modern physics with laboratory component.",
                prerequisites: ["PHYS 121", "MATH 165"],
                department: "Chemistry & Physics",
                enrollment: 22,
                capacity: 25,
                hasLab: true,
                labTime: "9:00 AM - 11:50 AM",
                labDays: [.friday],
                labLocation: "Chichester Physics Lab"
            ),
            
            createCourse(
                code: "GEOL 101",
                title: "Physical Geology",
                instructor: "Dr. Mark Stevens",
                location: "Chichester Science Center 201",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Study of Earth's materials, processes, and structure including minerals, rocks, earthquakes, volcanoes, and plate tectonics.",
                prerequisites: [],
                department: "Geological Sciences",
                enrollment: 30,
                capacity: 35,
                hasLab: true,
                labTime: "2:00 PM - 4:50 PM",
                labDays: [.tuesday],
                labLocation: "Chichester Geology Lab"
            ),
            
            // Political Science Courses
            createCourse(
                code: "POLI 101",
                title: "Introduction to American Government",
                instructor: "Dr. Jennifer Marshall",
                location: "Rotunda Hall 125",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Introduction to American political system including the Constitution, federalism, civil liberties, political parties, elections, and policy-making processes.",
                prerequisites: [],
                department: "Political Science",
                enrollment: 45,
                capacity: 50
            ),
            
            createCourse(
                code: "POLI 102",
                title: "Introduction to Comparative Politics",
                instructor: "Dr. Michael Chang",
                location: "Rotunda Hall 127",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Comparative study of political systems around the world including democratic and authoritarian regimes, political institutions, and governance structures.",
                prerequisites: [],
                department: "Political Science",
                enrollment: 35,
                capacity: 40
            ),
            
            createCourse(
                code: "POLI 103",
                title: "Introduction to International Relations",
                instructor: "Dr. Sarah Peterson",
                location: "Rotunda Hall 129",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Introduction to international politics including state behavior, diplomacy, international organizations, conflict resolution, and global issues.",
                prerequisites: [],
                department: "Political Science",
                enrollment: 40,
                capacity: 45
            ),
            
            createCourse(
                code: "POLI 201",
                title: "Constitutional Law",
                instructor: "Dr. David Reynolds",
                location: "Rotunda Hall 131",
                time: "10:00 AM - 11:15 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of constitutional interpretation through Supreme Court cases including judicial review, federalism, separation of powers, and constitutional rights.",
                prerequisites: ["POLI 101"],
                department: "Political Science",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "POLI 250",
                title: "Political Theory",
                instructor: "Dr. Elizabeth Warren",
                location: "Rotunda Hall 133",
                time: "1:00 PM - 2:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Examination of major political philosophers and theories from ancient to modern times including democracy, liberty, justice, and authority.",
                prerequisites: ["POLI 101"],
                department: "Political Science",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "POLI 300",
                title: "Public Policy Analysis",
                instructor: "Dr. Robert Chen",
                location: "Rotunda Hall 135",
                time: "9:30 AM - 10:45 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Analysis of public policy-making process including agenda-setting, policy formulation, implementation, and evaluation in various policy areas.",
                prerequisites: ["POLI 101", "STAT 250"],
                department: "Political Science",
                enrollment: 28,
                capacity: 32
            ),
            
            createCourse(
                code: "POLI 310",
                title: "American Political Parties",
                instructor: "Dr. Lisa Thompson",
                location: "Rotunda Hall 137",
                time: "11:00 AM - 11:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Study of political parties in America including party organization, electoral processes, campaign finance, and the role of parties in governance.",
                prerequisites: ["POLI 101"],
                department: "Political Science",
                enrollment: 32,
                capacity: 35
            ),
            
            createCourse(
                code: "POLI 320",
                title: "Congress and the Presidency",
                instructor: "Dr. James Mitchell",
                location: "Rotunda Hall 139",
                time: "2:00 PM - 2:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Examination of the legislative and executive branches including institutional structures, powers, and relationships in the American political system.",
                prerequisites: ["POLI 101"],
                department: "Political Science",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "POLI 330",
                title: "International Security",
                instructor: "Dr. Maria Rodriguez",
                location: "Rotunda Hall 141",
                time: "3:30 PM - 4:45 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Analysis of international security issues including military conflict, terrorism, nuclear weapons, peacekeeping, and security cooperation.",
                prerequisites: ["POLI 103"],
                department: "Political Science",
                enrollment: 22,
                capacity: 25
            ),
            
            createCourse(
                code: "POLI 340",
                title: "Comparative Democratization",
                instructor: "Dr. Ahmed Hassan",
                location: "Rotunda Hall 143",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Comparative study of democratic transitions and consolidation including case studies from different regions and analysis of democratization theories.",
                prerequisites: ["POLI 102"],
                department: "Political Science",
                enrollment: 20,
                capacity: 25
            ),
            
            createCourse(
                code: "POLI 350",
                title: "Political Research Methods",
                instructor: "Dr. Nancy Kim",
                location: "Rotunda Hall 145",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Introduction to quantitative and qualitative research methods in political science including research design, data collection, and statistical analysis.",
                prerequisites: ["POLI 101", "MATH 155"],
                department: "Political Science",
                enrollment: 24,
                capacity: 28,
                hasLab: true,
                labTime: "2:00 PM - 3:50 PM",
                labDays: [.friday],
                labLocation: "Rotunda Hall Computer Lab"
            ),
            
            createCourse(
                code: "POLI 360",
                title: "Civil Rights and Civil Liberties",
                instructor: "Dr. Patricia Johnson",
                location: "Rotunda Hall 147",
                time: "11:00 AM - 12:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Examination of constitutional rights and liberties including freedom of speech, religion, equal protection, and due process through Supreme Court cases.",
                prerequisites: ["POLI 101", "POLI 201"],
                department: "Political Science",
                enrollment: 28,
                capacity: 32
            ),
            
            createCourse(
                code: "POLI 370",
                title: "State and Local Government",
                instructor: "Dr. William Davis",
                location: "Rotunda Hall 149",
                time: "9:00 AM - 10:15 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of state and local political systems including federalism, state constitutions, governors, legislatures, courts, and local governance structures.",
                prerequisites: ["POLI 101"],
                department: "Political Science",
                enrollment: 26,
                capacity: 30
            ),
            
            createCourse(
                code: "POLI 380",
                title: "Environmental Politics",
                instructor: "Dr. Rachel Green",
                location: "Rotunda Hall 151",
                time: "2:00 PM - 3:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Analysis of environmental policy-making including climate change, natural resource management, environmental regulation, and sustainability politics.",
                prerequisites: ["POLI 101"],
                department: "Political Science",
                enrollment: 22,
                capacity: 25
            ),
            
            createCourse(
                code: "POLI 400",
                title: "Senior Seminar in Political Science",
                instructor: "Dr. Thomas Anderson",
                location: "Rotunda Hall 153",
                time: "6:00 PM - 8:30 PM",
                days: [.wednesday],
                credits: 3,
                description: "Capstone course for political science majors involving independent research, seminar discussions, and presentation of original research project.",
                prerequisites: ["POLI 350", "Senior Standing"],
                department: "Political Science",
                enrollment: 15,
                capacity: 18
            ),
            
            createCourse(
                code: "POLI 410",
                title: "Political Internship",
                instructor: "Dr. Jennifer Marshall",
                location: "Off-Campus",
                time: "TBA",
                days: [.monday, .tuesday, .wednesday, .thursday, .friday],
                credits: 3,
                description: "Supervised internship experience in government agencies, political campaigns, advocacy organizations, or other political settings with academic component.",
                prerequisites: ["Junior Standing", "Permission of Instructor"],
                department: "Political Science",
                enrollment: 12,
                capacity: 15
            ),
            
            // COMMUNICATION SCIENCES AND DISORDERS (CSDS)
            createCourse(
                code: "CSDS 101",
                title: "Introduction to Communication Disorders",
                instructor: "Dr. Rebecca Hayes",
                location: "Chichester Science Center 203",
                time: "9:00 AM - 10:15 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Overview of normal and disordered communication processes including speech, language, and hearing.",
                prerequisites: [],
                department: "Communication Sciences and Disorders",
                enrollment: 28,
                capacity: 30
            ),
            
            createCourse(
                code: "CSDS 210",
                title: "Anatomy and Physiology of Speech Mechanisms",
                instructor: "Dr. Michael Chen",
                location: "Chichester Science Center 204",
                time: "11:00 AM - 12:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Study of anatomical structures and physiological processes involved in speech production.",
                prerequisites: ["CSDS 101"],
                department: "Communication Sciences and Disorders",
                enrollment: 24,
                capacity: 26
            ),
            
            // COMMUNICATION (COMM)
            createCourse(
                code: "COMM 101",
                title: "Public Speaking",
                instructor: "Prof. Lisa Rodriguez",
                location: "Grainger Hall 205",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Development of skills in public speaking including speech preparation, delivery, and audience analysis.",
                prerequisites: [],
                department: "Communication Studies",
                enrollment: 22,
                capacity: 25
            ),
            
            createCourse(
                code: "COMM 150",
                title: "Media and Society",
                instructor: "Dr. Jennifer Williams",
                location: "Bedford Building 120",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Examination of mass media's role in society, including television, radio, print, and digital media.",
                prerequisites: [],
                department: "Communication Studies",
                enrollment: 35,
                capacity: 40
            ),
            
            createCourse(
                code: "COMM 250",
                title: "Interpersonal Communication",
                instructor: "Dr. Thomas Garcia",
                location: "Grainger Hall 208",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of communication processes in interpersonal relationships and small groups.",
                prerequisites: ["COMM 101"],
                department: "Communication Studies",
                enrollment: 18,
                capacity: 20
            ),
            
            // ANTHROPOLOGY (ANTH)
            createCourse(
                code: "ANTH 101",
                title: "Introduction to Anthropology",
                instructor: "Dr. Maria Santos",
                location: "Ruffner Hall 240",
                time: "9:00 AM - 10:15 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Introduction to the four fields of anthropology: cultural, physical, linguistic, and archaeological.",
                prerequisites: [],
                department: "Anthropology",
                enrollment: 32,
                capacity: 35
            ),
            
            createCourse(
                code: "ANTH 200",
                title: "Cultural Anthropology",
                instructor: "Dr. Robert Kim",
                location: "Ruffner Hall 242",
                time: "11:00 AM - 12:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Comparative study of human cultures, social organization, and cultural change.",
                prerequisites: ["ANTH 101"],
                department: "Anthropology",
                enrollment: 26,
                capacity: 30
            ),
            
            createCourse(
                code: "ANTH 202",
                title: "Archaeology",
                instructor: "Dr. Catherine Lee",
                location: "Ruffner Hall 245",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Introduction to archaeological methods, theory, and interpretation of material culture.",
                prerequisites: ["ANTH 101"],
                department: "Anthropology",
                enrollment: 20,
                capacity: 24
            ),
            
            createCourse(
                code: "ANTH 280",
                title: "Archaeological Laboratory Methods",
                instructor: "Dr. Catherine Lee",
                location: "Ruffner Hall Archaeology Lab",
                time: "3:30 PM - 6:20 PM",
                days: [.thursday],
                credits: 3,
                description: "Hands-on experience in archaeological laboratory techniques including artifact analysis and documentation.",
                prerequisites: ["ANTH 202"],
                department: "Anthropology",
                enrollment: 12,
                capacity: 15,
                hasLab: true,
                labTime: "3:30 PM - 6:20 PM",
                labDays: [.thursday],
                labLocation: "Ruffner Hall Archaeology Lab"
            ),
            
            // SOCIOLOGY (SOCL)
            createCourse(
                code: "SOCL 101",
                title: "Introduction to Sociology",
                instructor: "Dr. David Thompson",
                location: "Ruffner Hall 230",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Introduction to sociological perspectives on human behavior, social groups, and institutions.",
                prerequisites: [],
                department: "Sociology",
                enrollment: 40,
                capacity: 45
            ),
            
            createCourse(
                code: "SOCL 220",
                title: "Social Problems",
                instructor: "Dr. Angela Martinez",
                location: "Ruffner Hall 232",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Sociological analysis of contemporary social problems and potential solutions.",
                prerequisites: ["SOCL 101"],
                department: "Sociology",
                enrollment: 28,
                capacity: 32
            ),
            
            createCourse(
                code: "SOCL 300",
                title: "Research Methods in Sociology",
                instructor: "Dr. Kevin Brown",
                location: "Ruffner Hall 235",
                time: "9:00 AM - 10:15 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Introduction to quantitative and qualitative research methods in sociology.",
                prerequisites: ["SOCL 101", "MATH 161"],
                department: "Sociology",
                enrollment: 18,
                capacity: 22
            ),
            
            // THEATER (THEA)
            createCourse(
                code: "THEA 101",
                title: "Introduction to Theatre",
                instructor: "Prof. Sarah Daniels",
                location: "Jarman Auditorium 210",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Survey of theatre as an art form including history, dramatic literature, and production elements.",
                prerequisites: [],
                department: "Theatre",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "THEA 110",
                title: "Acting I",
                instructor: "Prof. Michael Stone",
                location: "Jarman Auditorium 120",
                time: "2:00 PM - 4:50 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Fundamentals of acting including improvisation, character development, and scene work.",
                prerequisites: [],
                department: "Theatre",
                enrollment: 15,
                capacity: 18
            ),
            
            createCourse(
                code: "THEA 220",
                title: "Stagecraft",
                instructor: "Prof. Jennifer Clark",
                location: "Jarman Auditorium Shop",
                time: "6:00 PM - 8:50 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Introduction to technical theatre including set construction, lighting, and sound design.",
                prerequisites: [],
                department: "Theatre",
                enrollment: 12,
                capacity: 16
            ),
            
            // MUSIC (MUSC)
            createCourse(
                code: "MUSC 100",
                title: "Music Appreciation",
                instructor: "Dr. Patricia Adams",
                location: "Wygal Music Building 125",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Introduction to musical elements, styles, and forms from various periods and cultures.",
                prerequisites: [],
                department: "Music",
                enrollment: 45,
                capacity: 50
            ),
            
            createCourse(
                code: "MUSC 111",
                title: "Music Theory I",
                instructor: "Dr. Richard Taylor",
                location: "Wygal Music Building 130",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Fundamentals of music theory including scales, intervals, triads, and basic harmonic progressions.",
                prerequisites: [],
                department: "Music",
                enrollment: 20,
                capacity: 24
            ),
            
            createCourse(
                code: "MUSC 171",
                title: "University Choir",
                instructor: "Dr. Lisa Anderson",
                location: "Wygal Music Building Choral Hall",
                time: "4:00 PM - 5:30 PM",
                days: [.tuesday, .thursday],
                credits: 1,
                description: "Large choral ensemble performing works from various musical periods and styles.",
                prerequisites: [],
                department: "Music",
                enrollment: 55,
                capacity: 60
            ),
            
            createCourse(
                code: "MUSC 181",
                title: "University Band",
                instructor: "Dr. Michael Johnson",
                location: "Wygal Music Building Band Room",
                time: "7:00 PM - 9:00 PM",
                days: [.tuesday, .thursday],
                credits: 1,
                description: "Concert band performing classical and contemporary wind band literature.",
                prerequisites: [],
                department: "Music",
                enrollment: 45,
                capacity: 50
            ),
            
            // PHILOSOPHY (PHIL)
            createCourse(
                code: "PHIL 101",
                title: "Introduction to Philosophy",
                instructor: "Dr. Jonathan White",
                location: "Ruffner Hall 120",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Introduction to fundamental philosophical questions and methods of reasoning.",
                prerequisites: [],
                department: "Philosophy",
                enrollment: 28,
                capacity: 32
            ),
            
            createCourse(
                code: "PHIL 220",
                title: "Ethics",
                instructor: "Dr. Margaret Foster",
                location: "Ruffner Hall 122",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of moral philosophy including major ethical theories and contemporary moral issues.",
                prerequisites: ["PHIL 101"],
                department: "Philosophy",
                enrollment: 22,
                capacity: 26
            ),
            
            createCourse(
                code: "PHIL 300",
                title: "History of Ancient Philosophy",
                instructor: "Dr. Steven Harris",
                location: "Ruffner Hall 125",
                time: "1:00 PM - 2:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Survey of ancient Greek and Roman philosophy from Pre-Socratics through Augustine.",
                prerequisites: ["PHIL 101"],
                department: "Philosophy",
                enrollment: 15,
                capacity: 20
            ),
            
            // RELIGION (RELI)
            createCourse(
                code: "RELI 101",
                title: "Introduction to World Religions",
                instructor: "Dr. Rachel Green",
                location: "Ruffner Hall 140",
                time: "9:00 AM - 10:15 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Survey of major world religions including Christianity, Islam, Judaism, Hinduism, and Buddhism.",
                prerequisites: [],
                department: "Religion",
                enrollment: 35,
                capacity: 40
            ),
            
            createCourse(
                code: "RELI 220",
                title: "Christianity and Culture",
                instructor: "Dr. Paul Henderson",
                location: "Ruffner Hall 142",
                time: "11:00 AM - 12:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Examination of Christian thought and its interaction with culture throughout history.",
                prerequisites: [],
                department: "Religion",
                enrollment: 20,
                capacity: 25
            ),
            
            // FRENCH (FREN)
            createCourse(
                code: "FREN 101",
                title: "Elementary French I",
                instructor: "Prof. Marie Dubois",
                location: "Grainger Hall 315",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Introduction to French language and culture with emphasis on speaking, listening, reading, and writing.",
                prerequisites: [],
                department: "Modern Languages",
                enrollment: 18,
                capacity: 20
            ),
            
            createCourse(
                code: "FREN 102",
                title: "Elementary French II",
                instructor: "Prof. Jean Moreau",
                location: "Grainger Hall 317",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Continuation of elementary French with increased focus on communication and cultural understanding.",
                prerequisites: ["FREN 101"],
                department: "Modern Languages",
                enrollment: 15,
                capacity: 18
            ),
            
            createCourse(
                code: "FREN 201",
                title: "Intermediate French I",
                instructor: "Dr. Catherine Rousseau",
                location: "Grainger Hall 319",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Development of intermediate-level French skills through reading, writing, and conversation.",
                prerequisites: ["FREN 102"],
                department: "Modern Languages",
                enrollment: 12,
                capacity: 15
            ),
            
            // SPANISH (SPAN)
            createCourse(
                code: "SPAN 101",
                title: "Elementary Spanish I",
                instructor: "Prof. Carlos Mendez",
                location: "Grainger Hall 325",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Introduction to Spanish language and Hispanic cultures with emphasis on basic communication skills.",
                prerequisites: [],
                department: "Modern Languages",
                enrollment: 22,
                capacity: 25
            ),
            
            createCourse(
                code: "SPAN 102",
                title: "Elementary Spanish II",
                instructor: "Prof. Ana Rodriguez",
                location: "Grainger Hall 327",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Continuation of elementary Spanish with expanded vocabulary and grammatical structures.",
                prerequisites: ["SPAN 101"],
                department: "Modern Languages",
                enrollment: 20,
                capacity: 23
            ),
            
            createCourse(
                code: "SPAN 201",
                title: "Intermediate Spanish I",
                instructor: "Dr. Elena Vargas",
                location: "Grainger Hall 329",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Development of intermediate Spanish skills through literature, culture, and conversation.",
                prerequisites: ["SPAN 102"],
                department: "Modern Languages",
                enrollment: 16,
                capacity: 20
            ),
            
            // GEOGRAPHY (GEOG)
            createCourse(
                code: "GEOG 101",
                title: "Introduction to Geography",
                instructor: "Dr. James Wilson",
                location: "Ruffner Hall 320",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Introduction to physical and human geography including landforms, climate, and cultural patterns.",
                prerequisites: [],
                department: "Geography",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "GEOG 200",
                title: "World Regional Geography",
                instructor: "Dr. Susan Parker",
                location: "Ruffner Hall 322",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Regional analysis of world geography emphasizing cultural, economic, and political patterns.",
                prerequisites: [],
                department: "Geography",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "GEOG 250",
                title: "Environmental Geography",
                instructor: "Dr. Michael Rogers",
                location: "Ruffner Hall 325",
                time: "11:00 AM - 12:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Study of human-environment interactions and environmental problems from a geographical perspective.",
                prerequisites: ["GEOG 101"],
                department: "Geography",
                enrollment: 20,
                capacity: 24
            ),
            
            // RECREATION (RECR)
            createCourse(
                code: "RECR 101",
                title: "Introduction to Recreation and Leisure",
                instructor: "Prof. Kelly Johnson",
                location: "Lancer Park Student Union 220",
                time: "9:00 AM - 10:15 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Overview of recreation and leisure as social phenomena and professional fields.",
                prerequisites: [],
                department: "Recreation and Tourism",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "RECR 250",
                title: "Recreation Programming",
                instructor: "Dr. Amanda Davis",
                location: "Lancer Park Student Union 225",
                time: "1:00 PM - 2:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Principles and practices of recreation program planning, implementation, and evaluation.",
                prerequisites: ["RECR 101"],
                department: "Recreation and Tourism",
                enrollment: 20,
                capacity: 25
            ),
            
            createCourse(
                code: "RECR 300",
                title: "Outdoor Recreation",
                instructor: "Prof. Brian Mitchell",
                location: "Lancer Park Student Union 230",
                time: "10:00 AM - 11:15 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of outdoor recreation resources, activities, and management practices.",
                prerequisites: ["RECR 101"],
                department: "Recreation and Tourism",
                enrollment: 18,
                capacity: 22
            ),
            
            // DANCE (DANC)
            createCourse(
                code: "DANC 101",
                title: "Introduction to Dance",
                instructor: "Prof. Laura Bennett",
                location: "Lancer Park Fitness Center Studio",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 2,
                description: "Introduction to various dance styles including modern, jazz, and cultural dance forms.",
                prerequisites: [],
                department: "Dance",
                enrollment: 20,
                capacity: 24
            ),
            
            createCourse(
                code: "DANC 150",
                title: "Ballet I",
                instructor: "Prof. Emily Watson",
                location: "Lancer Park Fitness Center Studio",
                time: "3:00 PM - 4:15 PM",
                days: [.monday, .wednesday],
                credits: 2,
                description: "Introduction to classical ballet technique including barre work and center combinations.",
                prerequisites: [],
                department: "Dance",
                enrollment: 15,
                capacity: 18
            ),
            
            createCourse(
                code: "DANC 170",
                title: "Modern Dance I",
                instructor: "Prof. Jessica Turner",
                location: "Lancer Park Fitness Center Studio",
                time: "4:30 PM - 5:45 PM",
                days: [.tuesday, .thursday],
                credits: 2,
                description: "Introduction to modern dance technique emphasizing creativity and personal expression.",
                prerequisites: [],
                department: "Dance",
                enrollment: 18,
                capacity: 22
            ),
            
            // GERMAN (GERM)
            createCourse(
                code: "GERM 101",
                title: "Elementary German I",
                instructor: "Prof. Klaus Weber",
                location: "Grainger Hall 335",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Introduction to German language and culture with emphasis on basic communication skills.",
                prerequisites: [],
                department: "Modern Languages",
                enrollment: 12,
                capacity: 15
            ),
            
            createCourse(
                code: "GERM 102",
                title: "Elementary German II",
                instructor: "Prof. Ingrid Mueller",
                location: "Grainger Hall 337",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Continuation of elementary German with expanded vocabulary and cultural topics.",
                prerequisites: ["GERM 101"],
                department: "Modern Languages",
                enrollment: 10,
                capacity: 13
            ),
            
            // WOMEN'S AND GENDER STUDIES (WGST)
            createCourse(
                code: "WGST 200",
                title: "Introduction to Women's and Gender Studies",
                instructor: "Dr. Patricia Moore",
                location: "Ruffner Hall 350",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Interdisciplinary introduction to feminist theories and gender issues across cultures.",
                prerequisites: [],
                department: "Women's and Gender Studies",
                enrollment: 22,
                capacity: 25
            ),
            
            createCourse(
                code: "WGST 300",
                title: "Gender and Society",
                instructor: "Dr. Karen Lewis",
                location: "Ruffner Hall 352",
                time: "2:00 PM - 3:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Sociological analysis of gender roles, inequality, and social change.",
                prerequisites: ["WGST 200"],
                department: "Women's and Gender Studies",
                enrollment: 18,
                capacity: 22
            ),
            
            // LEADERSHIP STUDIES (LDST)
            createCourse(
                code: "LDST 200",
                title: "Introduction to Leadership Studies",
                instructor: "Dr. Christopher Young",
                location: "Lancer Park Student Union 310",
                time: "9:00 AM - 10:15 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Examination of leadership theories, styles, and practices in various organizational contexts.",
                prerequisites: [],
                department: "Leadership Studies",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "LDST 300",
                title: "Ethical Leadership",
                instructor: "Dr. Sandra Williams",
                location: "Lancer Park Student Union 315",
                time: "1:00 PM - 2:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Study of ethical decision-making and moral leadership in personal and professional contexts.",
                prerequisites: ["LDST 200"],
                department: "Leadership Studies",
                enrollment: 25,
                capacity: 30
            ),
            
            // ADDITIONAL SCIENCE COURSES
            createCourse(
                code: "CHEM 151",
                title: "General Chemistry I",
                instructor: "Dr. Robert Thompson",
                location: "Chichester Science Center 152",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Introduction to general chemistry including atomic structure, bonding, and stoichiometry.",
                prerequisites: ["MATH 161"],
                department: "Chemistry",
                enrollment: 45,
                capacity: 50,
                hasLab: true,
                labTime: "1:00 PM - 3:50 PM",
                labDays: [.tuesday],
                labLocation: "Chichester Chemistry Lab A"
            ),
            
            createCourse(
                code: "CHEM 152",
                title: "General Chemistry II",
                instructor: "Dr. Linda Chang",
                location: "Chichester Science Center 152",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Continuation of general chemistry covering thermodynamics, kinetics, and equilibrium.",
                prerequisites: ["CHEM 151"],
                department: "Chemistry",
                enrollment: 40,
                capacity: 45,
                hasLab: true,
                labTime: "1:00 PM - 3:50 PM",
                labDays: [.thursday],
                labLocation: "Chichester Chemistry Lab B"
            ),
            
            createCourse(
                code: "PHYS 151",
                title: "College Physics I",
                instructor: "Dr. Mark Phillips",
                location: "Chichester Science Center 251",
                time: "11:00 AM - 11:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Introduction to mechanics, heat, and wave motion using algebra and trigonometry.",
                prerequisites: ["MATH 167"],
                department: "Physics",
                enrollment: 35,
                capacity: 40,
                hasLab: true,
                labTime: "2:00 PM - 4:50 PM",
                labDays: [.wednesday],
                labLocation: "Chichester Physics Lab"
            ),
            
            createCourse(
                code: "PHYS 152",
                title: "College Physics II",
                instructor: "Dr. Jennifer Liu",
                location: "Chichester Science Center 251",
                time: "12:00 PM - 12:50 PM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Continuation of college physics covering electricity, magnetism, and modern physics topics.",
                prerequisites: ["PHYS 151"],
                department: "Physics",
                enrollment: 32,
                capacity: 38,
                hasLab: true,
                labTime: "2:00 PM - 4:50 PM",
                labDays: [.friday],
                labLocation: "Chichester Physics Lab"
            ),
            
            // ADDITIONAL MATH COURSES
            createCourse(
                code: "MATH 265",
                title: "Calculus II",
                instructor: "Dr. Steven Anderson",
                location: "Chichester Science Center 321",
                time: "9:00 AM - 9:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Integration techniques, applications of integrals, infinite sequences and series.",
                prerequisites: ["MATH 167"],
                department: "Mathematics",
                enrollment: 28,
                capacity: 32
            ),
            
            createCourse(
                code: "MATH 266",
                title: "Calculus III",
                instructor: "Dr. Rachel Brooks",
                location: "Chichester Science Center 323",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Multivariable calculus including partial derivatives, multiple integrals, and vector calculus.",
                prerequisites: ["MATH 265"],
                department: "Mathematics",
                enrollment: 22,
                capacity: 26
            ),
            
            createCourse(
                code: "MATH 310",
                title: "Linear Algebra",
                instructor: "Dr. David Chen",
                location: "Chichester Science Center 325",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Vector spaces, linear transformations, matrices, eigenvalues, and applications.",
                prerequisites: ["MATH 265"],
                department: "Mathematics",
                enrollment: 18,
                capacity: 22
            ),
            
            // ADDITIONAL BUSINESS COURSES
            createCourse(
                code: "FINA 360",
                title: "Corporate Finance",
                instructor: "Dr. Michael Thompson",
                location: "Stevens Hall 205",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Financial management decisions including capital budgeting, cost of capital, and capital structure.",
                prerequisites: ["ACCT 242", "ECON 202"],
                department: "Finance",
                enrollment: 25,
                capacity: 30
            ),
            
            createCourse(
                code: "MANG 350",
                title: "Organizational Behavior",
                instructor: "Dr. Lisa Rodriguez",
                location: "Stevens Hall 210",
                time: "9:00 AM - 10:15 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of individual and group behavior in organizational settings.",
                prerequisites: ["MANG 201"],
                department: "Management",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "MARK 360",
                title: "Consumer Behavior",
                instructor: "Dr. Jennifer Kim",
                location: "Stevens Hall 215",
                time: "11:00 AM - 12:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Analysis of consumer decision-making processes and factors influencing purchasing behavior.",
                prerequisites: ["MARK 301"],
                department: "Marketing",
                enrollment: 28,
                capacity: 32
            ),
            
            // ART COURSES
            createCourse(
                code: "ART 110",
                title: "Crafts",
                instructor: "Prof. Sarah Mitchell",
                location: "Bedford Building Art Studio 1",
                time: "2:00 PM - 4:50 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Introduction to various craft techniques including ceramics, textiles, and jewelry making.",
                prerequisites: [],
                department: "Art",
                enrollment: 16,
                capacity: 20
            ),
            
            createCourse(
                code: "ART 120",
                title: "Foundations of Two-Dimensional Design",
                instructor: "Prof. David Kim",
                location: "Bedford Building Art Studio 2",
                time: "9:00 AM - 11:50 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Fundamental principles of two-dimensional design including composition, color theory, and visual elements.",
                prerequisites: [],
                department: "Art",
                enrollment: 18,
                capacity: 22
            ),
            
            createCourse(
                code: "ART 130",
                title: "Drawing I",
                instructor: "Prof. Emily Chen",
                location: "Bedford Building Drawing Studio",
                time: "10:00 AM - 12:50 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Introduction to basic drawing techniques using various media including pencil, charcoal, and conte crayon.",
                prerequisites: [],
                department: "Art",
                enrollment: 20,
                capacity: 24
            ),
            
            createCourse(
                code: "ART 155",
                title: "Basic Processes and Principles of Photography",
                instructor: "Prof. Michael Torres",
                location: "Bedford Building Photography Lab",
                time: "1:00 PM - 3:50 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Introduction to photography including camera operation, composition, lighting, and darkroom techniques.",
                prerequisites: [],
                department: "Art",
                enrollment: 14,
                capacity: 16,
                hasLab: true,
                labTime: "1:00 PM - 3:50 PM",
                labDays: [.tuesday, .thursday],
                labLocation: "Bedford Building Photography Lab"
            ),
            
            // AMERICAN SIGN LANGUAGE (ASL)
            createCourse(
                code: "ASL 110",
                title: "Beginning Language and Culture",
                instructor: "Prof. Amanda Johnson",
                location: "Grainger Hall 340",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Introduction to American Sign Language and Deaf culture with emphasis on basic communication skills.",
                prerequisites: [],
                department: "Modern Languages",
                enrollment: 16,
                capacity: 20
            ),
            
            createCourse(
                code: "ASL 210",
                title: "Beginning Integrated Language and Culture",
                instructor: "Prof. Robert Davis",
                location: "Grainger Hall 342",
                time: "1:00 PM - 2:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Continuation of ASL with expanded vocabulary and cultural understanding of the Deaf community.",
                prerequisites: ["ASL 110"],
                department: "Modern Languages",
                enrollment: 12,
                capacity: 16
            ),
            
            // INTERDISCIPLINARY STUDIES
            createCourse(
                code: "ISCS 101",
                title: "Introduction to Computer Science",
                instructor: "Dr. Kevin Park",
                location: "Chichester Science Center 401",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 3,
                description: "Introduction to computer programming, algorithms, and problem-solving using a high-level programming language.",
                prerequisites: [],
                department: "Computer Science",
                enrollment: 35,
                capacity: 40,
                hasLab: true,
                labTime: "2:00 PM - 3:50 PM",
                labDays: [.tuesday],
                labLocation: "Chichester Computer Lab"
            ),
            
            createCourse(
                code: "ISCS 202",
                title: "Data Structures",
                instructor: "Dr. Nancy Wilson",
                location: "Chichester Science Center 403",
                time: "11:00 AM - 12:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Study of fundamental data structures including arrays, linked lists, stacks, queues, trees, and graphs.",
                prerequisites: ["ISCS 101"],
                department: "Computer Science",
                enrollment: 28,
                capacity: 32,
                hasLab: true,
                labTime: "3:00 PM - 4:50 PM",
                labDays: [.thursday],
                labLocation: "Chichester Computer Lab"
            ),
            
            // KINESIOLOGY (KINS)
            createCourse(
                code: "KINS 101",
                title: "Introduction to Kinesiology",
                instructor: "Dr. Jessica Adams",
                location: "Lancer Park 301",
                time: "9:00 AM - 10:15 AM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Overview of the field of kinesiology including exercise science, biomechanics, and motor learning.",
                prerequisites: [],
                department: "Kinesiology",
                enrollment: 32,
                capacity: 36
            ),
            
            createCourse(
                code: "KINS 250",
                title: "Exercise Physiology",
                instructor: "Dr. Robert Martinez",
                location: "Lancer Park 303",
                time: "1:00 PM - 2:15 PM",
                days: [.monday, .wednesday],
                credits: 3,
                description: "Study of physiological responses and adaptations to exercise and physical activity.",
                prerequisites: ["KINS 101", "BIOL 152"],
                department: "Kinesiology",
                enrollment: 25,
                capacity: 30,
                hasLab: true,
                labTime: "3:00 PM - 4:50 PM",
                labDays: [.friday],
                labLocation: "Lancer Park Exercise Physiology Lab"
            ),
            
            // ENVIRONMENTAL SCIENCE (ENSC)
            createCourse(
                code: "ENSC 101",
                title: "Introduction to Environmental Science",
                instructor: "Dr. Patricia Green",
                location: "Chichester Science Center 301",
                time: "2:00 PM - 3:15 PM",
                days: [.tuesday, .thursday],
                credits: 3,
                description: "Interdisciplinary study of environmental problems including pollution, resource depletion, and climate change.",
                prerequisites: [],
                department: "Environmental Science",
                enrollment: 30,
                capacity: 35
            ),
            
            createCourse(
                code: "ENSC 250",
                title: "Environmental Chemistry",
                instructor: "Dr. Michael Foster",
                location: "Chichester Science Center 303",
                time: "10:00 AM - 10:50 AM",
                days: [.monday, .wednesday, .friday],
                credits: 4,
                description: "Chemical principles applied to environmental systems including air, water, and soil chemistry.",
                prerequisites: ["CHEM 152"],
                department: "Environmental Science",
                enrollment: 20,
                capacity: 24,
                hasLab: true,
                labTime: "1:00 PM - 3:50 PM",
                labDays: [.wednesday],
                labLocation: "Chichester Environmental Lab"
            )
        ]
    }
    
    // Helper method to create a course with standard parameters
    private static func createCourse(
        code: String,
        title: String,
        instructor: String,
        location: String,
        time: String,
        days: [Weekday],
        credits: Int,
        description: String,
        prerequisites: [String],
        department: String,
        enrollment: Int,
        capacity: Int,
        waitlist: Bool = true,
        hasLab: Bool = false,
        labTime: String? = nil,
        labDays: [Weekday]? = nil,
        labLocation: String? = nil
    ) -> Course {
        
        // Extract course number to determine course level
        let components = code.components(separatedBy: " ")
        var courseLevel: CourseLevel = .unknown
        
        if components.count >= 2, let courseNumber = Int(components[1]) {
            courseLevel = CourseLevel.fromCourseNumber(courseNumber)
        }
        
        return Course(
            courseCode: code,
            title: title,
            instructor: instructor,
            location: location,
            meetingTime: time,
            meetingDays: days,
            credits: credits,
            description: description,
            prerequisites: prerequisites,
            department: department,
            semester: "Fall 2025",
            capacity: capacity,
            currentEnrollment: enrollment,
            isWaitlistAvailable: waitlist,
            courseLevel: courseLevel,
            hasLab: hasLab,
            labMeetingTime: labTime,
            labMeetingDays: labDays,
            labLocation: labLocation
        )
    }
} 