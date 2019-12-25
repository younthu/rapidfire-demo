# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: 'admin@pansheng.com', password: 'code123', admin: true)
User.create(email: 'user1@pansheng.com', password: '123code', admin: false)

s = Rapidfire::Survey.create!(name: "业绩比一比(1/2)", introduction: "随便说点什么")

s.tag_list.add("survey1")
s.save

s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "从事的投资机构类型？",
                    answer_options:"VC\r\nPE-GROWTH\r\nPE-BUYOUT\r\nOTHER")
s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "所在机构投资币种？",
                    answer_options:"美元\r\n人民币\r\n双币种")

s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "所在机构股权投资管理规模？（亿美元）",
                    answer_options:">50\r\n10-50\r\n5-10\r\n<5")

q = s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "投资第一个项目是哪一年？",
                    answer_options:"<2005\r\n2005-2010\r\n2010-2015\r\n>2015")
q.tag_list.add("q4")
q.save

q5 = s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "累计投资项目数量？",
                    answer_options:">100\r\n51-100\r\n20-50\r\n<20")
q5.tag_list.add("q5")
q5.save

s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "累计投资项目金额？（亿美元）",
                    answer_options:">10\r\n5-10\r\n2-5\r\n<2")

s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "已退出项目合计数量？",
                    answer_options:">10\r\n5-10\r\n3-5\r\n<3")

s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "IPO退出项目数量？(不含新三板）",
                    answer_options:">10\r\n4-10\r\n1-3\r\n0")

s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "并购退出项目数量？",
                    answer_options:">10\r\n4-10\r\n1-3\r\n0")

s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "已退出项目合计金额？(亿美元）",
                    answer_options:">10\r\n5-10\r\n0-5\r\n0")

s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "已退出项目合计回报倍数？(现金或股价计）",
                    answer_options:">10\r\n5-10\r\n3-5\r\n<3")

s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "已获得CARRY分配金额（百万美元）",
                    answer_options:">5\r\n1-5\r\n0-1\r\n0")


# if Q1 = A

s = Rapidfire::Survey.create!(name: "业绩比一比(2/2)", introduction: "随便说点什么")
s.tag_list.add("surveyA")
s.save

s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "主导投资的独角兽数量？(估值>10亿美元）",
                    answer_options:">3\r\n2-3\r\n1-2\r\n0")
s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: ">20+账面回报的项目数量？",
                    answer_options:">3\r\n2-3\r\n1-2\r\n0")
s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "10-20+账面回报的项目数量？",
                    answer_options:">3\r\n2-3\r\n1-2\r\n0")
s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "5-10账面回报的项目数量？",
                    answer_options:">5\r\n3-5\r\n1-3\r\n0")

# if Q1 = B
s = Rapidfire::Survey.create!(name: "业绩比一比(2/2)", introduction: "随便说点什么")
s.tag_list.add("surveyB")
s.save

s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "主导投资收入>$100m项目数量？",
                    answer_options:">3\r\n2-3\r\n1-2\r\n0")
s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "投资后收入增长>20X项目数量",
                    answer_options:">3\r\n2-3\r\n1-2\r\n0")
s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "投资后收入增长10-20X项目数量",
                    answer_options:">3\r\n2-3\r\n1-2\r\n0")
s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "投资后收入增长5-10X项目数量",
                    answer_options:">5\r\n3-5\r\n1-3\r\n0")


# if Q1 = C
s = Rapidfire::Survey.create!(name: "业绩比一比(2/2)", introduction: "随便说点什么")
s.tag_list.add("surveyC")
s.save

s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "主导投资EV>$1bn项目数量？",
                    answer_options:">3\r\n2-3\r\n1-2\r\n0")
s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "投资后收入增长>5X项目数量",
                    answer_options:">3\r\n2-3\r\n1-2\r\n0")
s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "投资后收入增长3-5X项目数量",
                    answer_options:">3\r\n2-3\r\n1-2\r\n0")
s.questions.create!(type:"Rapidfire::Questions::Radio", question_text: "投资后收入增长2-3X项目数量",
                    answer_options:">5\r\n3-5\r\n1-3\r\n0")