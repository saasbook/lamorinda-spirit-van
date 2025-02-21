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
      }
    ]
  end
end
