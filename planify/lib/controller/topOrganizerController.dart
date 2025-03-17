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
            "4.8 (120+) - Clients love our attention to detail, creative designs, and flawless execution. We ensure every wedding is personalized and stress-free. Our experienced planners have organized over 500 weddings globally, receiving accolades for impeccable service and extraordinary themes.",
        "experience": "10 years",
        "budget":
            "\$5000 - \$50000 (Customizable packages available for luxury and intimate weddings, including destination packages and themed setups)",
        "about":
            "We create unforgettable wedding experiences with unique themes, expert coordination, and a network of the best vendors. From grand royal weddings to intimate beach ceremonies, we turn dreams into reality. Our team includes top-tier decorators, caterers, and entertainment specialists to craft a flawless experience.",
        "events": [
          "assets/images/wedding/wedding1.jpg",
          "assets/images/wedding/wedding2.jpg",
          "assets/images/wedding/wedding4.jpg"
        ],
      },
      {
        "name": "Luxury Events",
        "image": "assets/images/wedding/wedding2.jpg",
        "contact": "+0987654321",
        "reviews":
            "4.7 (98+) - Clients appreciate our dedication to sophistication, premium décor, and seamless event planning. Every detail is meticulously curated to reflect elegance and grandeur, making every wedding a unique masterpiece.",
        "budget":
            "\$10000 - \$80000 (Includes premium venues, luxury floral arrangements, celebrity entertainment, and exclusive services)",
        "experience": "12 years",
        "about":
            "Luxury Events specializes in high-end wedding planning with a touch of class. From destination weddings to celebrity-style receptions, we ensure every detail is exquisite. Our premium services include designer outfits, 5-star accommodations, and elite venue selections.",
        "events": [
          "assets/images/wedding/wedding2.jpg",
          "assets/images/wedding/wedding1.jpg",
          "assets/images/wedding/wedding3.jpg",
        ],
      }
    ],
    "Music": [
      {
        "name": "Rock Nation",
        "image": "assets/images/music/music2.jpg",
        "contact": "+1112233445",
        "reviews":
            "4.6 (200+) - Highly recommended for their electrifying stage presence and exceptional music selection. Our live band performances create an unforgettable ambiance, featuring top artists and cutting-edge sound systems.",
        "experience": "15 years",
        "budget":
            "\$3000 - \$25000 (Includes live bands, DJ services, custom sound setups, LED stage lighting, and special effects)",
        "about":
            "We specialize in live music events, concerts, and private gigs, bringing high-energy performances with world-class audio setups. Whether it's a rock concert, jazz evening, or EDM festival, we ensure an immersive musical experience.",
        "events": [
          "assets/images/music/music4.jpg",
          "assets/images/music/music3.jpg",
          "assets/images/music/music2.jpg",
        ],
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
