Faker::Config.locale = :en

### User ###

5.times do |n|
  first_name = Faker::Name.unique.first_name
  last_name = Faker::Name.unique.last_name
  password = "password"
  location = User.locations.keys.sample
  admin = Faker::Boolean.boolean

  User.create!( name: "#{first_name} #{last_name}",
                email: "#{last_name.downcase}@example.com",
                password: password,
                password_confirmation: password,
                location: location,
                admin: admin
               )
end

puts "User Data ...ok"


### Tag ###

Tag.create!( name: "グルメ" )
Tag.create!( name: "自然" )
Tag.create!( name: "映えスポット" )
Tag.create!( name: "お土産" )
Tag.create!( name: "体験型" )
Tag.create!( name: "歴史" )
Tag.create!( name: "パワースポット" )

puts "Tag Data ...ok"


### Spot ###

Spot.create!(
  name: "竜神大吊橋",
  images: [
    File.open('app/assets/images/sample/kenpoku1.jpg'),
    File.open('app/assets/images/sample/kenpoku2.jpg'),
    File.open('app/assets/images/sample/kenpoku3.jpg')
  ],
  area: "県北",
  address: "茨城県常陸太田市天下野町",
  phone: "未掲載",
  holiday: "未掲載",
  sales_copy: "全長375m、高さ100mのスリルを体験",
  detail_description: "竜神大吊橋は、迫力と美しさに満ちた観光名所です。全長375メートル、高さがおよそ100メートルの吊橋は、自然と調和したデザインで周囲の景色と一体化しています。橋を渡ると、壮大な山々と深い渓谷が広がり、絶景を満喫できます。\r\n\r\nさらに竜神大吊橋では、バンジージャンプの体験も楽しむことができます。吊橋から勇敢に身を投げ出すことで、非日常のスリルと興奮を味わえます。自由落下の瞬間から跳び上がる反動までの一瞬は、まさに忘れられない体験となるでしょう。",
  simple_description: "全長375m、高さ100mのスリルを体験",
  tag_ids: [ Tag.find_by(name: "体験型").id, Tag.find_by(name: "映えスポット").id ]
 )

 Spot.create!(
  name: "国営ひたち海浜公園",
  images: [
    File.open('app/assets/images/sample/kenou1.jpg'),
    File.open('app/assets/images/sample/kenou2.png'),
    File.open('app/assets/images/sample/kenou3.jpg')
  ],
  area: "県央",
  address: "茨城県ひたちなか市馬渡字大沼",
  phone: "未掲載",
  holiday: "未掲載",
  sales_copy: "花と緑がいっぱいの都市公園",
  detail_description: "国営ひたち海浜公園は、広大な敷地内に自然の美しさと多彩な施設が魅力の観光地です。春には美しいチューリップや桜の花が咲き誇り、夏には広大な海岸線で海水浴やマリンスポーツが楽しめます。秋には紅葉が美しい季節で、散策コースで四季折々の風景を満喫できます。公園内にはイベント広場や野外ステージがあり、コンサートやフェスティバルなどのイベントが開催されます。また、ウォーターガーデンやプール、ゴーカートなどのレジャー施設も充実しています。豊かな自然環境とアクティビティのバラエティが魅力で、家族や友人と楽しむことができる素晴らしい場所です。",
  simple_description: "花と緑がいっぱいの都市公園",
  tag_ids: [ Tag.find_by(name: "自然").id, Tag.find_by(name: "映えスポット").id ]
 )

 Spot.create!(
  name: "大洗海鮮市場",
  images: [
    File.open('app/assets/images/sample/kenou4.jpg'),
    File.open('app/assets/images/sample/kenou5.jpg'),
    File.open('app/assets/images/sample/kenou6.jpg')
  ],
  area: "県央",
  address: "茨城県東茨城郡大洗町磯浜町",
  phone: "未掲載",
  holiday: "未掲載",
  sales_copy: "新鮮な海の幸が満載　海の恵みを存分に楽しむ",
  detail_description: "茨城県に位置する「大洗海鮮市場」は、新鮮な海産物とグルメが楽しめる人気の観光スポットです。海に近い立地にあり、地元の漁師たちが水揚げしたばかりの魚介類や海産物が豊富に並びます。\r\n\r\n市場内には、新鮮な魚介類を直接購入することができます。活きた魚や新鮮な貝類、シーフードの種類も豊富で、自宅での調理やバーベキューに最適です。また、市場内の飲食店では、その場で調理された海鮮料理を楽しむこともできます。新鮮なネタで握られる寿司や、焼きガキ、海鮮丼など、多彩なメニューが魅力です。\r\n\r\nさらに、大洗海鮮市場では地元の特産品や加工品も取り扱われています。茨城県の名産品やお土産品を手に入れることができ、旅の思い出を大切な人たちと共有することもできます。\r\n\r\n訪れる人々は、新鮮な海の幸を堪能しながら、地元の雰囲気や文化に触れることができます。海の香り漂う雰囲気の中で、地元の人々との交流や、海の幸を味わう贅沢な時間を過ごすことができるでしょう。\r\n\r\n大洗海鮮市場は、海の恵みを存分に味わいたい方にとって、魅力的なスポットです。新鮮な海産物と美味しい料理に舌鼓を打ちながら、地元の風景や人々と触れ合ってみてください。きっと充実した食体験と思い出に残る時間を過ごせることでしょう。",
  simple_description: "新鮮な海の幸が満載　海の恵みを存分に楽しむ",
  tag_ids: [ Tag.find_by(name: "グルメ").id, Tag.find_by(name: "お土産").id ]
 )

 Spot.create!(
  name: "小貝川ふれあい公園",
  images: [
    File.open('app/assets/images/sample/kensei1.jpg'),
    File.open('app/assets/images/sample/kensei2.jpg'),
    File.open('app/assets/images/sample/kensei3.jpg')
  ],
  area: "県西",
  address: "茨城県下妻市堀篭",
  phone: "未掲載",
  holiday: "未掲載",
  sales_copy: "川沿いに続く約3.2万㎡のお花畑",
  detail_description: "茨城県に位置する「小貝川ふれあい公園」は、自然とふれあえる穏やかな公園です。広大な敷地には、美しい芝生広場や木々が広がり、四季折々の風景を楽しむことができます。\r\n\r\n公園内には、遊具やベンチなどが配置されており、家族連れや友人同士が楽しいひと時を過ごすことができます。子供たちは広々とした芝生で遊びながら、思いっきり元気に遊ぶことができます。\r\n\r\nまた、小貝川ふれあい公園には川沿いの遊歩道もあります。散策しながら小鳥のさえずりや川のせせらぎを感じることができ、心が癒されます。特に桜の季節には、川沿いの桜並木が美しい景色を創り出し、訪れる人々を魅了します。\r\n\r\n公園内にはバーベキューエリアもあり、自然の中でおいしい食事を楽しむこともできます。家族や友人と一緒に、楽しいバーベキューパーティーを開催するのもおすすめです。\r\n\r\n小貝川ふれあい公園は、自然に触れながらリラックスできる場所であり、のんびりとした時間を過ごすのに最適なスポットです。ピクニックや散策、レジャーアクティビティを楽しむために、ぜひ足を運んでみてください。自然の恵みに触れながら心身ともにリフレッシュできるでしょう。",
  simple_description: "川沿いに続く約3.2万㎡のお花畑",
  tag_ids: [ Tag.find_by(name: "自然").id, Tag.find_by(name: "映えスポット").id ]
 )

 Spot.create!(
  name: "筑波山",
  images: [
    File.open('app/assets/images/sample/kennan1.png'),
    File.open('app/assets/images/sample/kennan2.jpg'),
    File.open('app/assets/images/sample/kennan3.jpg')
  ],
  area: "県南",
  address: "茨城県つくば市筑波",
  phone: "未掲載",
  holiday: "未掲載",
  sales_copy: "関東で唯一の日本百名山　茨城のシンボル",
  detail_description: "筑波山は、茨城県つくば市に位置する日本の有名な山です。標高877メートルのこの山は、美しい自然景観や歴史的な意義を持ち、多くの観光客や登山愛好家に人気です。\r\nさまざまなルートやコースがあり、初心者から経験豊富な登山者まで楽しむことができます。以下に、筑波山の主な観光スポットや特徴をいくつか紹介します。\r\n頂上には展望台があり、360度のパノラマビューが広がります。頂上からは、周囲の美しい風景や近隣の都市を一望することができます。\r\n筑波山の麓には筑波山神社があり、古くから信仰を集めています。参道や拝殿など、美しい建造物があり、神聖な雰囲気を感じることができます。\r\n登山やハイキングに最適な場所で、さまざまなコースが整備されており、美しい森林や滝、渓谷を通り抜けながら自然を満喫することができます。\r\n四季折々の美しい風景が楽しめ、春には桜の花が咲き乱れ、秋には紅葉が美しい景色を作り出します。",
  simple_description: "関東で唯一の日本百名山　茨城のシンボル",
  tag_ids: [ Tag.find_by(name: "自然").id, Tag.find_by(name: "映えスポット").id ]
 )

Spot.create!(
  name: "鹿島神宮",
  images: [
    File.open('app/assets/images/sample/rokko1.png'),
    File.open('app/assets/images/sample/rokko2.jpg'),
    File.open('app/assets/images/sample/rokko3.png')
  ],
  area: "鹿行",
  address: "茨城県鹿嶋市宮中",
  phone: "未掲載",
  holiday: "未掲載",
  sales_copy: "神武天皇元年創建の由緒ある神社",
  detail_description: "鹿島神宮は、茨城県鹿嶋市にある日本の代表的な神社であり、歴史と美しさが魅力の観光地です。神宮は神道の総本山の一つであり、創建は古く、紀元前の時代までさかのぼります。その歴史と格式を感じさせる本殿や社殿は、荘厳かつ美しい建築様式で、参拝者を魅了します。\r\n縁結びや勝利の神様としても知られており、多くの人々が厄除けや願い事を祈願するために訪れます。特に縁結びの神様として有名で、結婚式や成人式などの祝福を受けるために多くの人々が訪れます。\r\n鹿島神宮は、日本の歴史と文化を感じることができる特別な場所であり、神聖さと美しさが融合した魅力的な観光地です。歴史愛好家や神社巡りが好きな人々にとって、必見のスポットです。訪れる際には神聖な雰囲気を心に刻み、穏やかな時間を過ごしてください。",
  simple_description: "神武天皇元年創建の由緒ある神社",
  tag_ids: [ Tag.find_by(name: "歴史").id, Tag.find_by(name: "パワースポット").id ]
 )


puts "Spot Data ...ok"


### Favorite ###

User.all.each do |user|
  spot_ids = Spot.pluck(:id).sample(rand(1..3))
  spot_ids.each do |spot_id|
    Favorite.create(user_id: user.id, spot_id: spot_id)
  end
end

puts "Favorite Data ...ok"
