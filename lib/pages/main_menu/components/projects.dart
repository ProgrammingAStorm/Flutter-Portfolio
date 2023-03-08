import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  static const List<Map<String, List<String>>> projects = [
    {
      "name": ["Flutter Portfolio"],
      "tech": ["Flutter"],
      "description": [
        '''
     This project has two goals:
     1. Make a stylized portfolio that is both generally pleasing to look at, and technically impressive to any viewing prospective employers.
     
     2. Get practice with Flutter for a future project.
     
     Bonus: I just kinda curious.
     
     Personally, I feel like this project was a total success. It looks good, its hand-made, and the effects are nice. Flutter's development experience is an absolute DREAM to work with, and the documentation is super informative and intuitive; I cannot praise Flutter enoough, and I will definitely use it again.
     Big plus too is that, all of Flutter is Object-Oriented, so it was a great opportunity to get experience with it. And, the VS Code plugins for Dart and Flutter made the whole process a dream; the intellisence made the process of figuring out what types any given parameter expected, what static functions I had available from a class, or what enum types were possible super trivial.'''
      ],
      "keyPoints": [
        "Mouse-Seeking Gradient",
        "Sunrise/Sunset-Simulating Gradient",
        "Responsive Design",
        "Object-Oriented"
      ],
      "deployment": [
        "https://programmingastorm.github.io/Flutter-Portfolio/#/"
      ],
      "repo": ["https://github.com/ProgrammingAStorm/Flutter-Portfolio"],
      "takeAways": [
        "Flutter has a great developer experience.",
        "Flutter is a great example of OOP done very well.",
        "Flutter has some of the best documentation I've had the pleasure of using.",
        "Flutter was a bit obtuse coming from React, but the overall process is pretty simple.",
        "Flutter's animation API was very intuitive to use, and made the process of making the animations about the animation logic instead of API implementation.",
        "I like Dart's strongly-typed maps versus Javascript's loosely-typed maps, because it forces you to really think about how to optimize the shape of your data."
      ]
    },
    {
      "name": ["Tailwind Resume"],
      "tech": ["React", "Tailwind", "Vite"],
      "description": [
        '''
     This project had 3 goals:
     1. Make a stylized resume in hopes of catching the eye of anyone who sees it, whether a layman or industry professional.
     
     2. Get practice with Tailwind
     
     3. Get practice with Vite
     
     Bonus: Convert the page to a PDF to be easily sent to employers.

     I would say this project was an out-of-the-park success. The layout is simple, but pleasing, the background is layered and complex, and the overall result is greater than the sum of its parts.
     Vite is honestly a game-changer for me, and I'm never touching create-react-app again. My whole experience with Vite was phenominal: the setup was easy, the hot-reload times were fast, and the integration with Taillwind was absolutely seemless. I had heard a lot of great things about Vite and I was far, FAR from disappointed.
     As for Tailwind, and to keep myself from rambling too much, all I can say is, its just plain great. The way it abstracts the basics of CSS and makes it both approachable and intuitive makes it a very powerful tool.
     The back-most background is hand-made and the SVG waves and such were generated with a purpose-built tool called Haikei.'''
      ],
      "keyPoints": [
        "Stylized",
        "Hand-Made Background",
        "Custom-Generated SVG",
      ],
      "deployment": ["https://programmingastorm.github.io/Resume-Template/"],
      "repo": ["https://github.com/ProgrammingAStorm/Resume-Template"],
      "takeAways": [
        "Tailwind is a very powerful tool for quickly and easily building nice-looking webpages.",
        "Tailwind is very worth the hype.",
        "I will be using Tailwind in the future.",
        "Vite is very fast and very easy to use.",
        "Vite make generating projects very simple.",
        "I will be using Vite again."
      ]
    },
    {
      "name": ["Instaclone"],
      "tech": ["React", "Node", "Express", "MongoDB", "Multer", "Mongoose"],
      "description": [
        '''
     This project had one goal:
     
     1. To be a serviceable clone of Instagram.
     
     There are a few limitations to be aware of, as this project was the capstone of a coding bootcamp:
     
     1. The team I was given to lead was small; inluding myself, there were only four members.
     
     2. Most of the team still had work sechedules outside of the coding bootcamp, so we couldn't maintain daily stand-ups, and not everyone could code every day of the week.
     
     3. The project had a time limit of only a week and a half.
     
     All that being said, it's a pretty decent showing of our skills I think. I mean, honestly, its not really up to the standards of the general public. Heck! Its not up to my standards. But, for being short one guy with only a week and a half, and the fact that its functioning too, I would say its pretty good.
     I honestly didn't code too much of it though. I did what was portioned to me in the beginning, that being the file uploading on the front-end and the file handling on the back-end, but after that, since I was the leader, I was the one going back and forth making sure everyone else was taken care of.
     The whole week was both super stressful and exhilarating, and I loved every moment of it. The teamwork, the communication, and the feeling of getting it done at the last second by the skin of your teeth all left me with all sorts of feelings of pride, relief, and accomplishment all smashed together.
     That all being said though, even though its not super pretty, I still love it, and I think its a pretty good showing of my abilities as a full-stack developer.'''
      ],
      "keyPoints": [
        "Responsive",
        "MVC",
        "Content-Driven",
      ],
      "deployment": ["https://instaclonev2.herokuapp.com/"],
      "repo": ["https://github.com/ProgrammingAStorm/Instaclone"],
      "takeAways": [
        "The MERN stack is a very effective way of making full-stack web apps.",
        "A week and a half is not a lot of time to make a perfect looking web app with a small team.",
        "A week and a half is just barely enough time to make a funtion web app with a small team.",
        "Express is nice because it makes web servers pretty easy to use.",
        "Node is nice because it makes it easier for front-end devs to work with back-end code.",
        "Don't try to upload files to your cloud server's file system; that's what storage buckets are for."
      ]
    },
  ];

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final List<bool> _isOpen = [for (var project in Projects.projects) false];

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (i, isOpen) {
        setState(() {
          _isOpen[i] = !isOpen;
        });
      },
      children: Projects.projects.asMap().entries.map((entry) {
        return ExpansionPanel(
            backgroundColor: Colors.deepPurpleAccent,
            canTapOnHeader: true,
            isExpanded: _isOpen[entry.key],
            headerBuilder: (context, isOpen) {
              return Container(
                margin: const EdgeInsets.all(5),
                child: Center(
                  child: Text(
                    entry.value["name"]!.first,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
            body: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                border: Border.all(color: Colors.deepPurpleAccent, width: 3),
              ),
              child: Project(entry: entry.value),
            ));
      }).toList(),
    );
  }
}

class Project extends StatelessWidget {
  const Project({super.key, required this.entry});

  final Map<String, List<String>> entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          // Tech and Key Point
          Container(
            margin: const EdgeInsets.all(5),
            child: Row(
              children: [
                // Tech column to allow for a header
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Column(
                    children: [
                      // Header
                      Text(
                        "Tech",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      // List of techs
                      Column(
                        children: [
                          for (var tech in entry["tech"]!.toList())
                            Text(
                              '\u2022$tech',
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                        ],
                      )
                    ],
                  ),
                ),
                // Key point column with header
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Column(
                    children: [
                      // Header
                      Text(
                        "Key Points",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      // List of points
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var point in entry["keyPoints"]!.toList())
                            Text(
                              '\u2022$point',
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Description
          // Container for the border
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(color: Colors.deepPurpleAccent))),
            child: Column(
              children: [
                // Header
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                // Description
                for (var description in entry['description']!.toList())
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
              ],
            ),
          ),
          // Take-Aways, Repo, and Deployment
          // Container for the border
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(color: Colors.deepPurpleAccent))),
            child: Row(children: [
              // Take-Aways
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      'Take-Aways',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var takeAway in entry['takeAways']!.toList())
                          Text(
                            '\u2022$takeAway',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                      ],
                    )
                  ],
                ),
              ),
              // Repo and Deployment
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Column(
                    children: [
                      Column(children: [
                        Text(
                          "Deployment:",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                            onPressed: () async {
                              final Uri url =
                                  Uri.parse(entry['deployment']!.first);

                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            child: Text(
                              entry['deployment']!.first,
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ))
                      ]),
                      Column(children: [
                        Text(
                          "Repository:",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                            onPressed: () async {
                              final Uri url = Uri.parse(entry['repo']!.first);

                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            child: Text(
                              entry['repo']!.first,
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ))
                      ])
                    ],
                  ))
            ]),
          )
        ],
      ),
    );
  }
}
