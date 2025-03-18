import 'package:get/get.dart';

class CategoryController extends GetxController {
  final List<Map<String, String>> categories = [
    {"name": "Wedding", "image": "assets/images/wedding/wedding2.jpg"},
    {"name": "Music", "image": "assets/images/music/music3.jpg"},
    {"name": "Corporate", "image": "assets/images/corporate/corporate1.jpg"},
    {"name": "Sports", "image": "assets/images/sports/sports1.jpg"},
    {"name": "Tech", "image": "assets/images/tech/tech1.jpg"},
    {"name": "Fashion", "image": "assets/images/event.jpg"}
  ];
  final Map<String, List<Map<String, dynamic>>> organizers = {
    "Wedding": [
      {
        "name": "Dream Weddings",
        "image": "assets/images/wedding/wedding1.jpg",
        "contact": "+1234567890",
        "reviews":
            "4.8 (120+) - Clients love our attention to detail, creative designs, and flawless execution. We ensure every wedding is personalized and stress-free. Our experienced planners have organized over 500 weddings globally, receiving accolades for impeccable service and extraordinary themes. We are known for our warm and professional team, who go above and beyond to accommodate last-minute changes and client preferences.",
        "experience": "10 years",
        "budget":
            "\$6000 - \$55000 (Basic, premium, and luxury packages available with flexible add-ons for unique themes)",
        "about":
            "We create unforgettable wedding experiences with unique themes, expert coordination, and a network of the best vendors. From grand royal weddings to intimate beach ceremonies, we turn dreams into reality. Our team includes top-tier decorators, caterers, and entertainment specialists to craft a flawless experience. We also offer complete destination wedding management, ensuring a seamless event from guest accommodations to travel and catering.",
        "events": [
          "assets/images/wedding/wedding1.jpg",
          "assets/images/wedding/wedding2.jpg",
          "assets/images/wedding/wedding4.jpg"
        ]
      },
      {
        "name": "Luxury Events",
        "image": "assets/images/wedding/wedding2.jpg",
        "contact": "+0987654321",
        "reviews":
            "4.7 (98+) - Clients appreciate our dedication to sophistication, premium décor, and seamless event planning. Every detail is meticulously curated to reflect elegance and grandeur, making every wedding a unique masterpiece. We’ve hosted celebrity weddings and high-profile events with unparalleled success. Our team’s ability to transform any venue into a luxurious setting has earned consistent praise.",
        "budget":
            "\$12000 - \$85000 (Includes premium venues, luxury floral arrangements, celebrity entertainment, and exclusive services)",
        "experience": "12 years",
        "about":
            "Luxury Events specializes in high-end wedding planning with a touch of class. From destination weddings to celebrity-style receptions, we ensure every detail is exquisite. Our premium services include designer outfits, 5-star accommodations, and elite venue selections. We work with the finest florists, caterers, and entertainment providers to craft an experience that reflects sophistication and style.",
        "events": [
          "assets/images/wedding/wedding2.jpg",
          "assets/images/wedding/wedding1.jpg",
          "assets/images/wedding/wedding3.jpg"
        ]
      },
      {
        "name": "Elegant Affairs",
        "image": "assets/images/wedding/wedding3.jpg",
        "contact": "+1112233445",
        "reviews":
            "4.9 (150+) - Known for timeless elegance and exceptional service. Clients love the sophisticated touch and flawless organization. We provide personalized attention, ensuring that every detail matches the couple’s vision. The team’s creativity and problem-solving skills have been praised by high-profile clients.",
        "budget":
            "\$10000 - \$70000 (Tailored packages for upscale and modern weddings)",
        "experience": "8 years",
        "about":
            "Elegant Affairs delivers high-class wedding planning with a focus on modern design and refined style. From floral arrangements to gourmet cuisine, every element is curated to perfection. We specialize in unique seating arrangements, interactive guest experiences, and custom decor inspired by the latest design trends. Our signature 'floating floral ceiling' installation has been a showstopper at many events.",
        "events": [
          "assets/images/wedding/wedding3.jpg",
          "assets/images/wedding/wedding4.jpg",
          "assets/images/wedding/wedding5.jpg"
        ]
      },
      {
        "name": "Royal Celebrations",
        "image": "assets/images/wedding/wedding4.jpg",
        "contact": "+9998887776",
        "reviews":
            "4.6 (110+) - Specializes in grand, royal-style weddings with lavish decor and premium venues. Clients praise our ability to recreate the opulence of historic palaces with modern comfort. The team’s professionalism and attention to detail have made even the most complex events run seamlessly.",
        "budget":
            "\$20000 - \$120000 (Luxury royal-themed packages with elite services and palace-style venues)",
        "experience": "15 years",
        "about":
            "Royal Celebrations is known for organizing luxurious, large-scale weddings with a touch of royalty. Their team ensures a grand experience with top-tier catering and world-class decorations. From gold-accented mandaps to custom-designed bridal gowns, every element is crafted to perfection. We have exclusive partnerships with premium venues and luxury travel companies for a full-service royal experience.",
        "events": [
          "assets/images/wedding/wedding4.jpg",
          "assets/images/wedding/wedding6.jpg",
          "assets/images/wedding/wedding7.jpg"
        ]
      },
      {
        "name": "Classic Weddings",
        "image": "assets/images/wedding/wedding5.jpg",
        "contact": "+1122334455",
        "reviews":
            "4.5 (90+) - Clients love the traditional and heartwarming style of Classic Weddings. The team’s ability to blend cultural elements with modern touches has been praised. Guests have often complimented the warm atmosphere and thoughtful details.",
        "budget":
            "\$4000 - \$32000 (Traditional packages with modern elements available)",
        "experience": "7 years",
        "about":
            "Classic Weddings blends tradition with modern elegance to create a heartwarming experience. They specialize in family-focused ceremonies and intimate gatherings. Our team is skilled in handling multi-day events with religious rituals and personalized themes. We also offer live music, authentic cuisine, and culturally inspired decor to honor traditions while introducing modern sophistication.",
        "events": [
          "assets/images/wedding/wedding5.jpg",
          "assets/images/wedding/wedding8.jpg",
          "assets/images/wedding/wedding9.jpg"
        ]
      },
      {
        "name": "Boho Bliss",
        "image": "assets/images/wedding/wedding8.jpg",
        "contact": "+5566778899",
        "reviews":
            "4.6 (100+) - Experts in bohemian-style weddings with natural elements and creative themes. Clients appreciate the relaxed atmosphere and eco-friendly touches. The team’s attention to sustainable practices and artisanal decor has been well-received.",
        "budget":
            "\$5000 - \$27000 (Bohemian-style packages with rustic and natural decor)",
        "experience": "5 years",
        "about":
            "Boho Bliss is known for creative, nature-inspired weddings. They specialize in outdoor ceremonies, rustic decor, and handcrafted elements. We work closely with local artisans to provide sustainable materials and decor pieces. Popular features include flower crowns, handmade pottery, and organic catering options.",
        "events": [
          "assets/images/wedding/wedding8.jpg",
          "assets/images/wedding/wedding10.jpg",
          "assets/images/wedding/wedding3.jpg"
        ]
      },
      {
        "name": "Destination Dreams",
        "image": "assets/images/wedding/wedding6.jpg",
        "contact": "+4455667788",
        "reviews":
            "4.7 (130+) - Experts in destination weddings with breathtaking views and flawless execution. Clients value the stress-free experience and the team’s ability to handle logistics across different countries. The team’s extensive knowledge of local cultures and legal requirements ensures smooth planning.",
        "budget":
            "\$12000 - \$80000 (Includes travel, premium stays, and top-notch catering)",
        "experience": "9 years",
        "about":
            "Destination Dreams specializes in planning breathtaking destination weddings. We manage everything from travel to decor, ensuring a seamless experience. We offer wedding planning at exotic beaches, historic castles, and mountain resorts. Our team takes care of guest logistics, ensuring a comfortable and memorable experience for everyone involved.",
        "events": [
          "assets/images/wedding/wedding6.jpg",
          "assets/images/wedding/wedding7.jpg",
          "assets/images/wedding/wedding8.jpg"
        ]
      }
    ],
    "Music": [
      {
        "name": "Rock Nation",
        "image": "assets/images/music/music1.jpg",
        "contact": "+1112233445",
        "reviews":
            "4.6 (200+) - Highly recommended for their electrifying stage presence and exceptional music selection. Our live band performances create an unforgettable ambiance, featuring top artists and cutting-edge sound systems.",
        "experience": "15 years",
        "budget":
            "\$3000 - \$25000 (Includes live bands, DJ services, custom sound setups, LED stage lighting, and special effects)",
        "about":
            "We specialize in live music events, concerts, and private gigs, bringing high-energy performances with world-class audio setups. Whether it's a rock concert, jazz evening, or EDM festival, we ensure an immersive musical experience.",
        "events": [
          "assets/images/music/music2.jpg",
          "assets/images/music/music3.jpg",
          "assets/images/music/music4.jpg"
        ]
      },
      {
        "name": "Jazz Harmony",
        "image": "assets/images/music/music5.jpg",
        "contact": "+1113344556",
        "reviews":
            "4.8 (150+) - Known for their smooth sound and sophisticated style. The perfect choice for an elegant evening or a chill lounge atmosphere.",
        "experience": "10 years",
        "budget":
            "\$2000 - \$15000 (Includes live jazz band, saxophone soloist, and ambient lighting)",
        "about":
            "Jazz Harmony delivers soulful jazz music, blending classic and contemporary sounds. Perfect for corporate events, weddings, and private parties.",
        "events": [
          "assets/images/music/music6.jpg",
          "assets/images/music/music7.jpg",
          "assets/images/music/music8.jpg"
        ]
      },
      {
        "name": "EDM Pulse",
        "image": "assets/images/music/music9.jpg",
        "contact": "+1115566778",
        "reviews":
            "4.7 (180+) - High-energy EDM sets with stunning visuals and mind-blowing beats. A top choice for festivals and club events.",
        "experience": "12 years",
        "budget":
            "\$5000 - \$30000 (Includes top DJs, laser shows, and dynamic light displays)",
        "about":
            "EDM Pulse creates an immersive club experience with high-energy beats and stunning visual effects. Perfect for large festivals, nightclubs, and private parties.",
        "events": [
          "assets/images/music/music10.jpg",
          "assets/images/music/music11.jpg",
          "assets/images/music/music12.jpg"
        ]
      },
      {
        "name": "Acoustic Vibes",
        "image": "assets/images/music/music13.jpg",
        "contact": "+1117788990",
        "reviews":
            "4.5 (120+) - A relaxed acoustic experience with a soulful touch. Ideal for intimate gatherings and laid-back events.",
        "experience": "8 years",
        "budget":
            "\$1000 - \$10000 (Includes acoustic guitar, vocalists, and custom sound setup)",
        "about":
            "Acoustic Vibes delivers heartfelt performances with acoustic guitars and smooth vocals. Ideal for weddings, private parties, and relaxed social events.",
        "events": [
          "assets/images/music/music1.jpg",
          "assets/images/music/music2.jpg",
          "assets/images/music/music3.jpg"
        ]
      },
      {
        "name": "Symphony Nights",
        "image": "assets/images/music/music4.jpg",
        "contact": "+1118899001",
        "reviews":
            "4.9 (100+) - Beautiful classical symphonies and orchestral performances. Ideal for weddings and corporate galas.",
        "experience": "20 years",
        "budget":
            "\$4000 - \$20000 (Includes full orchestra, conductor, and classical music arrangements)",
        "about":
            "Symphony Nights delivers rich, immersive classical performances, combining violins, cellos, and brass instruments to create a grand ambiance.",
        "events": [
          "assets/images/music/music5.jpg",
          "assets/images/music/music6.jpg",
          "assets/images/music/music7.jpg"
        ]
      },
      {
        "name": "Pop Sensation",
        "image": "assets/images/music/music8.jpg",
        "contact": "+1113344557",
        "reviews":
            "4.6 (220+) - High-energy pop performances featuring top chart hits and vibrant stage presence.",
        "experience": "9 years",
        "budget":
            "\$3000 - \$18000 (Includes pop band, backup singers, and dynamic lighting)",
        "about":
            "Pop Sensation brings the energy of pop music to your event with top hits and vibrant stage visuals. Ideal for parties and festivals.",
        "events": [
          "assets/images/music/music9.jpg",
          "assets/images/music/music10.jpg",
          "assets/images/music/music11.jpg"
        ]
      },
      {
        "name": "Hip-Hop Beats",
        "image": "assets/images/music/music12.jpg",
        "contact": "+1111122334",
        "reviews":
            "4.7 (175+) - High-energy hip-hop beats with live MCs and dancers. Perfect for urban-style events and nightclubs.",
        "experience": "11 years",
        "budget":
            "\$2500 - \$12000 (Includes MC, backup dancers, and custom beats)",
        "about":
            "Hip-Hop Beats delivers authentic hip-hop experiences with professional MCs, beat makers, and dancers, creating a high-energy vibe.",
        "events": [
          "assets/images/music/music13.jpg",
          "assets/images/music/music1.jpg",
          "assets/images/music/music2.jpg"
        ]
      },
      {
        "name": "Reggae Groove",
        "image": "assets/images/music/music3.jpg",
        "contact": "+1114433221",
        "reviews":
            "4.5 (140+) - Smooth reggae beats and laid-back vibes. Ideal for beach parties and summer festivals.",
        "experience": "14 years",
        "budget":
            "\$2000 - \$10000 (Includes reggae band, vocalists, and percussionists)",
        "about":
            "Reggae Groove creates a chill atmosphere with rhythmic beats and soulful vocals. Perfect for beach events, lounges, and relaxed gatherings.",
        "events": [
          "assets/images/music/music4.jpg",
          "assets/images/music/music5.jpg",
          "assets/images/music/music6.jpg"
        ]
      }
    ],
    "Corporate": [
      {
        "name": "Elite Conferences",
        "image": "assets/images/corporate/corporate1.jpg",
        "contact": "+1445566778",
        "reviews":
            "4.9 (220+) - Known for seamless conference management, top-tier guest experiences, and professionalism. Our corporate events are tailored to maximize networking opportunities and business growth.",
        "experience": "18 years",
        "budget":
            "\$5000 - \$50000 (Includes venue bookings, speaker arrangements, technical support, catering, and branding solutions)",
        "about":
            "Providing world-class corporate event management, from global summits to leadership retreats, with state-of-the-art facilities and executive services. Our events feature interactive sessions, panel discussions, and VIP guest handling.",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      }
    ],
    "Tech": [
      {
        "name": "Innovate Tech Conferences",
        "image": "assets/images/event.jpg",
        "contact": "+1889900112",
        "reviews":
            "4.9 (300+) - Praised for cutting-edge conference execution, innovative setups, and seamless hybrid event management. Our tech summits attract global industry leaders and feature interactive AI-driven sessions.",
        "experience": "20 years",
        "budget":
            "\$7000 - \$75000 (Includes digital platforms, VR integrations, AI-driven networking tools, and live streaming options)",
        "about":
            "Organizing the most futuristic tech events with AI-driven networking, live streaming, and the latest innovations in event technology. Our events include hackathons, product launches, and keynote speeches by top tech influencers.",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      }
    ]
  };
}
