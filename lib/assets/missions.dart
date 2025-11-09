final List<Map<String, dynamic>> missions = [
  {
    'id': 1,
    'name': 'H-FARM Tractor',
    'type': 'installazione/statua',
    'latitude': 45.564845,
    'longitude': 12.435304,
    'shortDescription': 'Explore the iconic red tractor.',
    'notes':
        'Storico trattore rosso all’ingresso del campus H-FARM, simbolo del legame tra innovazione digitale e radici agricole venete.',
    'status': 'active',
    'token': 0.001,
    'images': [
      {
        'caption': 'H-FARM Tractor',
        'url': 'assets/images/missions/trattore.png',
      },
    ],
    'campaign': 1, // H-FARM Icons,
    'mission': {
      'type': 'photo',
      'description': 'Take a photo with the tractor.',
    },
  },
  {
    'id': 2,
    'name': 'Colle Umberto\'s Church',
    'type': 'chiesa/storico',
    'latitude': 45.9579,
    'longitude': 12.3481,
    'shortDescription': 'Discover the hilltop church and its views.',
    'notes':
        'Antica chiesa immersa tra le colline trevigiane, punto panoramico ideale per esplorare storia e paesaggio locale.',
    'status': 'active',
    'token': 0.010,
    'images': [
      {
        'caption': 'Colle Umberto\'s Church',
        'url': 'assets/images/missions/chiesa.png',
      },
    ],
    'campaign': 2, // Treviso Secrets
  },
  {
    'id': 3,
    'name': 'Fontana delle Tette',
    'type': 'fontana/storico',
    'latitude': 45.6669,
    'longitude': 12.2455,
    'shortDescription': 'Explore the ancient fountain of Treviso.',
    'notes':
        'Riproduzione della celebre fontana rinascimentale, simbolo della città di Treviso e delle sue tradizioni popolari.',
    'status': 'completed',
    'token': 0.010,
    'images': [
      {
        'caption': 'Fontana delle Tette',
        'url': 'assets/images/missions/fontana.png',
      },
    ],
    'campaign': 2, // Treviso Secrets
  },
  {
    'id': 4,
    'name': 'Clock Tower of Mestre',
    'type': 'torre/campanile',
    'latitude': 45.4894,
    'longitude': 12.2421,
    'shortDescription': 'Reach the heart of Mestre’s old town.',
    'notes':
        'Storico campanile che domina Piazza Ferretto, punto di riferimento urbano e tappa chiave per scoprire Mestre.',
    'status': 'completed',
    'token': 0.001,
    'images': [
      {
        'caption': 'Clock Tower of Mestre',
        'url': 'assets/images/missions/campanile-mestre.png',
      },
    ],
    'campaign': 3, // Mestre Highlights
  },
  {
    'id': 5,
    'name': 'Farmhouse in Treviso',
    'type': 'agriturismo/paesaggio',
    'latitude': 45.6830,
    'longitude': 12.2520,
    'shortDescription': 'Visit a traditional Venetian farmhouse.',
    'notes':
        'Cascina tipica della campagna trevigiana, perfetta per raccontare il legame tra territorio, enogastronomia e ospitalità locale.',
    'status': 'active',
    'token': 0.001,
    'images': [
      {
        'caption': 'Farmhouse in Treviso',
        'url': 'assets/images/missions/agriturismo-treviso.png',
      },
    ],
    'campaign': 2, // Treviso Secrets
  },
  // Nuove missioni basate sulle immagini trovate
  {
    'id': 6,
    'name': 'H-FARM Innovation Library',
    'type': 'edificio/tecnologia',
    'latitude': 45.564920,
    'longitude': 12.435180,
    'shortDescription': 'Visit the futuristic library space.',
    'notes':
        'Biblioteca innovativa di H-FARM, spazio di co-working e studio che rappresenta il futuro dell\'educazione digitale sostenibile.',
    'status': 'active',
    'token': 0.002,
    'images': [
      {
        'caption': 'H-FARM Innovation Library',
        'url': 'assets/images/missions/H-FARM_library.jpg',
      },
    ],
    'campaign': 1, // H-FARM Icons
    'mission': {
      'type': 'check-in',
      'description': 'Check-in at the library and share your sustainable innovation idea.',
    },
  },
  {
    'id': 7,
    'name': 'H-FARM Serra',
    'type': 'agricoltura/sostenibilità',
    'latitude': 45.564500,
    'longitude': 12.435800,
    'shortDescription': 'Discover sustainable agriculture in action.',
    'notes':
        'Serra tecnologica H-FARM che dimostra l\'innovazione nell\'agricoltura sostenibile, unendo tradizione e tecnologia per un futuro green.',
    'status': 'active',
    'token': 0.003,
    'images': [
      {
        'caption': 'H-FARM Sustainable Serra',
        'url': 'assets/images/missions/H-FARM_serra.jpeg',
      },
    ],
    'campaign': 1, // H-FARM Icons
    'mission': {
      'type': 'interactive',
      'description': 'Learn about hydroponic farming and take a photo of sustainable agriculture.',
    },
  },
  {
    'id': 8,
    'name': 'Mulinetto della Croda',
    'type': 'mulino/paesaggio',
    'latitude': 45.8856,
    'longitude': 12.2142,
    'shortDescription': 'Discover the historic watermill in nature.',
    'notes':
        'Antico mulino ad acqua immerso nella natura delle Prealpi trevigiane, esempio perfetto di energia rinnovabile storica e turismo sostenibile.',
    'status': 'active',
    'token': 0.015,
    'images': [
      {
        'caption': 'Historic Watermill in Nature',
        'url': 'assets/images/missions/mulinetto_della_croda.jpg',
      },
    ],
    'campaign': 4, // Veneto Heritage
    'mission': {
      'type': 'educational',
      'description': 'Learn about historic renewable energy and take photos of the watermill.',
    },
  },
  {
    'id': 9,
    'name': 'Castello di Conegliano',
    'type': 'castello/storico',
    'latitude': 45.8897,
    'longitude': 12.2976,
    'shortDescription': 'Explore the medieval castle on the hill.',
    'notes':
        'Castello medievale che domina Conegliano, punto panoramico eccezionale per scoprire la storia e i paesaggi del Prosecco DOCG.',
    'status': 'active',
    'token': 0.020,
    'images': [
      {
        'caption': 'Medieval Castle of Conegliano',
        'url': 'assets/images/campaigns/castello_conegliano.jpeg',
      },
    ],
    'campaign': 5, // Prosecco Hills
    'mission': {
      'type': 'hike',
      'description': 'Hike to the castle and enjoy sustainable wine tourism views.',
    },
  },
  {
    'id': 10,
    'name': 'Forte Marghera',
    'type': 'forte/storico',
    'latitude': 45.4725,
    'longitude': 12.2508,
    'shortDescription': 'Visit the historic Austrian fortress.',
    'notes':
        'Fortezza austriaca del XIX secolo, oggi parco urbano e spazio culturale che unisce storia militare e riqualificazione sostenibile.',
    'status': 'active',
    'token': 0.012,
    'images': [
      {
        'caption': 'Historic Fort Marghera',
        'url': 'assets/images/campaigns/forte_marghera.jpeg',
      },
    ],
    'campaign': 3, // Mestre Highlights
    'mission': {
      'type': 'cultural',
      'description': 'Explore the fort\'s history and its transformation into a green urban park.',
    },
  },
  {
    'id': 4,
    'name': 'La Serra',
    'type': 'agriturismo/paesaggio',
    'latitude': 45.564686831572615,
    'longitude': 12.42806688871246,
    'shortDescription': 'Posto incredibile.',
    'notes': 'Posto incredibile al di fuori del tempo e dello spazio bello',
    'status': 'active',
    'token': 0.001,
    'images': [
      {
        'caption': 'Farmhouse in Treviso',
        'url': 'assets/images/missions/agriturismo-treviso.png',
      },
    ],
    'campaign': 1,
    'mission': {
      'type': 'photo',
      'description': 'Take a photo with the tractor.',
    },
  },
];
