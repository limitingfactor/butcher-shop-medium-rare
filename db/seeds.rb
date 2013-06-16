cow = Factory(:animal, name: "Cow")
["Chuck", "Short Loin", "Rib"].each { |primal_cut| Factory(:primal_cut, name: primal_cut, animal_id: cow.id) }
["Prime Rib", "Ribeye"].each { |cut| Factory(:cut, name: cut, primal_cut_id: PrimalCut.where(name: "Rib").first.id) }
["Porterhouse", "T-bone", "Strip"].each { |primal_cut| Factory(:cut, name: primal_cut, animal_id: cow.id) }

pig = Factory(:animal, name: "Pig")
["Jowl", "Ham", "Loin"].each { |primal_cut| Factory(:primal_cut, name: primal_cut, animal_id: pig.id) }
["Loin Chop", "Blade Roast"].each { |cut| Factory(:cut, name: cut, primal_cut_id: PrimalCut.where(name: "Loin").first.id) }
["Baby Back Ribs", "Spare Ribs", "Hock"].each { |primal_cut| Factory(:cut, name: primal_cut, animal_id: pig.id) }
