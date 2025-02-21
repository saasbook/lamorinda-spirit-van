module SeedData
  def self.drivers
    [
      {
        name:         'John Doe',
        phone:        '0000000000',
        email:        'jd@lamorinda.com',
        shifts:       {
                        "sun": [
                          "am"
                        ],
                        "mon": [
                          "pm"
                        ],
                        "tue": [
                          "LARC"
                        ],
                        "wed": [
                          "shopping"
                        ],
                        "thu": [
                          "Café Costa"
                        ],
                        "fri": [
                          "am",
                          "pm"
                        ],
                        "sat": [
                          ""
                        ]
                      },
        active:       true
      },
      {
        name:         'Jane Dal',
        phone:        '000-000-0000',
        email:        'jd@lamorinda.com',
        shifts:       {
                        "sun": [
                          "am"
                        ],
                        "mon": [
                          "pm"
                        ],
                        "tue": [
                          "LARC"
                        ],
                        "wed": [
                          "shopping"
                        ],
                        "thu": [
                          "Café Costa"
                        ],
                        "fri": [
                          "am",
                          "pm"
                        ],
                        "sat": [
                          ""
                        ]
                      },
        active:       true
      },
      {
        name:         'Mike Jackson',
        phone:        '510-687-8824',
        email:        'mike@lamorinda.com',
        shifts:       {
                        "sun": [
                          ""
                        ],
                        "mon": [
                          "am"
                        ],
                        "tue": [
                          "shopping"
                        ],
                        "wed": [
                          "LARC"
                        ],
                        "thu": [
                          ""
                        ],
                        "fri": [
                          "am"
                        ],
                        "sat": [
                          ""
                        ]
                      },
        active:       true
      },
      {
        name:         'Peter Packer',
        phone:        '510-123-4567',
        email:        'peter@lamorinda.com',
        shifts:       {
                        "sun": [
                          "pm"
                        ],
                        "mon": [
                          ""
                        ],
                        "tue": [
                          ""
                        ],
                        "wed": [
                          "LARC"
                        ],
                        "thu": [
                          ""
                        ],
                        "fri": [
                          "am"
                        ],
                        "sat": [
                          ""
                        ]
                      },
        active:       true
      },
      {
        name:         'Robert Tony',
        phone:        '510-123-3333',
        email:        '',
        shifts:       {
                        "sun": [
                          "pm"
                        ],
                        "mon": [
                          ""
                        ],
                        "tue": [
                          ""
                        ],
                        "wed": [
                          "LARC"
                        ],
                        "thu": [
                          ""
                        ],
                        "fri": [
                          "am"
                        ],
                        "sat": [
                          ""
                        ]
                      },
        active:       true
      },
      {
        name:         'Mary Jane',
        phone:        '666-999-0000',
        email:        'mary@lamorinda.com',
        shifts:       {
                        "sun": [
                          "am"
                        ],
                        "mon": [
                          "pm"
                        ],
                        "tue": [
                          ""
                        ],
                        "wed": [
                          ""
                        ],
                        "thu": [
                          ""
                        ],
                        "fri": [
                          ""
                        ],
                        "sat": [
                          ""
                        ]
                      },
        active:       false
      }
    ]
  end
end
