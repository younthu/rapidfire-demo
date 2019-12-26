class Rapidfire::AttemptsControllerDecorator
  Rapidfire::AttemptsController.class_eval do

    def show
      puts "params: #{attempt_params_for_find}"
      @attempt = Rapidfire::Attempt.find(attempt_params_for_find[:id])
      puts "#{@attempt}"
    end

    def after_answer_path_for
      puts "current survey: #{@survey.tag_list.first}. #{Rapidfire::Engine.routes.url_helpers.new_survey_attempt_path(Rapidfire::Survey.tagged_with("surveyA").first)}"
      if @survey.tag_list.first == "survey1"
        puts "to_model: #{@attempt_builder.to_model.answers.first.answer_text}"
        if @attempt_builder.to_model.answers.first.answer_text == "VC"
          puts "User selected VC"
          Rapidfire::Engine.routes.url_helpers.new_survey_attempt_path(Rapidfire::Survey.tagged_with("surveyA").first)
        elsif @attempt_builder.to_model.answers.first.answer_text == "PE-GROWTH"

          puts "User selected PE-GROWTH"
          Rapidfire::Engine.routes.url_helpers.new_survey_attempt_path(Rapidfire::Survey.tagged_with("surveyB").first)
        elsif @attempt_builder.to_model.answers.first.answer_text == "PE-BUYOUT"
          puts "User selected OTHER"
          Rapidfire::Engine.routes.url_helpers.new_survey_attempt_path(Rapidfire::Survey.tagged_with("surveyC").first)
        else
          # finish and go to rate page.
          puts "Hit nothing"

          Rapidfire::Engine.routes.url_helpers.surveys_path
        end
      else
        # finish and go to rate page.
        puts "we are done"



        user = @attempt_builder.to_model.user
        s1 = Rapidfire::Survey.tagged_with("survey1").last
        sa = Rapidfire::Survey.tagged_with("surveyA").last
        sb = Rapidfire::Survey.tagged_with("surveyB").last
        sc = Rapidfire::Survey.tagged_with("surveyC").last

        # Attempt = Rapidfire::Attempt
        # Survey  = Rapidfire::Survey
        # IF Q5
        # 累计投资项目数量？	>100	51-100	20-50	<20	INT
        # OR q4
        # 投资第一个项目是哪一年？	<2005	2005-2010	2010-2015	>2015	INT
        #
        # 投资经验分类	前辈	老兵	中坚	新人
        attempt1 = Rapidfire::Attempt.where(survey: s1, user: user).last
        attempta = Rapidfire::Attempt.where(survey: sa, user: user).last
        attemptb = Rapidfire::Attempt.where(survey: sb, user: user).last
        attemptc = Rapidfire::Attempt.where(survey: sc, user: user).last

        a4 = attempt1.answers[3].answer_text
        a5 = attempt1.answers[4].answer_text
        a7 = attempt1.answers[6].answer_text
        exp = ""
        if a4 == "<2005" or a5 == ">100"
          exp = "前辈"
        elsif a4 == "2005-2010" or a5 == "51-100"
          exp = "老兵"
        elsif a4 == "2010-2015" or a5 == "20-50"
          exp = "中坚"
        else
          exp = "新人"
        end
        #
        # IF
        # q7, 已退出项目合计数量？	>10	5-10	3-5	<3	INT
        # OR
        #  q10, 已退出项目合计金额？(亿美元）	>10	5-10	0-5	0	FLOAT
        # AND
        #  q8, IPO退出项目数量？(不含新三板）	>0	>0	>0	>0	INT
        #  q9, 并购退出项目数量？	>0	>0	>0	>0	INT
        #
        # 退出经验分类	TOP 1%	TOP 5%	TOP 10%	NOT Top 10%
        a7 = attempt1.answers[6].answer_text
        a8 = attempt1.answers[7].answer_text
        a9 = attempt1.answers[8].answer_text
        a10 = attempt1.answers[9].answer_text
        exit_rate = "NOT Top 10%"
        if a8=="0" or a9 == "0"
          exit_rate = "NOT Top 10%"
        elsif a7 == ">10" or a10 == ">10"
          exit_rate = "TOP 1%"
        elsif a7 == "5-10" or a10 == "5-10"
          exit_rate = "TOP 5%"
        elsif a7 == "0-5" or a10 == "3-5"
          exit_rate = "TOP 10%"
        else
          exit_rate = "NOT Top 10%"
        end

        #
        #  q1, 从事的投资机构类型？	A
        # AND
        # 已退出项目合计回报倍数？(现金或股价计）	>10	5-10	3-5	<3	FLOAT
        # OR
        # 主导投资的独角兽数量？(估值>10亿美元）	>3	2-3	1-2	0	INT
        # OR
        # >20+账面回报的项目数量？	>3	2-3	1-2	0	INT
        # OR
        # 10-20+账面回报的项目数量？	>3	2-3	1-2	0	INT
        # OR
        # 5-10账面回报的项目数量？	>5	3-5	1-3	0	INT
        #
        # 综合业绩分类: VC	TOP 1%	TOP 1%	TOP 10%	NOT Top 10%
        over_performance = "TOP 1%"
        a1 = attempt1.answers[0].answer_text
        a11 = attempt1.answers[10].answer_text
        if a1 == "VC"
          aa1 = attempta.answers[0].answer_text
          aa2 = attempta.answers[1].answer_text
          aa3 = attempta.answers[2].answer_text
          aa4 = attempta.answers[3].answer_text

          if a11 == ">10" or aa1 == ">3" or aa2 == ">3" or aa3 == ">3" or aa4 == ">5"
            over_performance = "TOP 1%"
          elsif a11 == "5-10" or  aa1 == "2-3" or aa2 == "2-3" or aa3 == "2-3" or aa4 == "3-5"
            over_performance = "TOP 1%"
          elsif a11 == "3-5" or  aa1 == "2-3" or aa2 == "1-2" or aa3 == "1-2" or aa4 == "1-3"
            over_performance = "TOP 10%"
          else
            over_performance = "NOT TOP 10%"
          end
        end
        #
        #  从事的投资机构类型？	B
        # AND
        # 已退出项目合计回报倍数？(现金或股价计）	>10	5-10	3-5	<3	FLOAT
        # OR
        # 主导投资收入>$100m项目数量？	>3	2-3	1-2	0	INT
        # OR
        # 投资后收入增长10-20X项目数量	>3	2-3	1-2	0	INT
        # OR
        # 投资后收入增长5-10X项目数量	>5	3-5	1-3	0	INT
        #
        # 综合业绩分类: GROWTH	TOP 1%	TOP 1%	TOP 10%	NOT Top 10%
        if a1 == "PE-GROWTH"
          aa1 = attemptb.answers[0].answer_text
          aa2 = attemptb.answers[1].answer_text
          aa3 = attemptb.answers[2].answer_text
          aa4 = attemptb.answers[3].answer_text

          if a11 == ">10" or aa1 == ">3" or aa3 == ">3"  or aa4 == ">5"
            over_performance = "TOP 1%"
          elsif a11 == "5-10" or aa1 == "2-3" or aa3 == "2-3" or aa4 == "3-5"
            over_performance = "TOP 1%"
          elsif a11 == "3-5" or aa1 == "1-2" or aa3 == "1-2" or aa4 == "1-3"
            over_performance = "TOP 10%"
          else
            over_performance = "NOT TOP 10%"
          end
        end
        #
        #从事的投资机构类型？	C
        # AND
        # 已退出项目合计回报倍数？(现金或股价计）	>10	5-10	3-5	<3	FLOAT
        # OR
        # 投资后收入增长>5X项目数量	>3	2-3	1-2	0	INT
        # OR
        # 投资后收入增长3-5X项目数量	>3	2-3	1-2	0	INT
        #
        # 综合业绩分类: PE-BUYOUT	TOP 1%	TOP 1%	TOP 5%	NOT Top 10%
        if a1 == "PE-BUYOUT"
          aa1 = attemptc.answers[0].answer_text
          aa2 = attemptc.answers[1].answer_text
          aa3 = attemptc.answers[2].answer_text
          aa4 = attemptc.answers[3].answer_text

          if aa1 == ">10" or aa2 == ">3" or aa3 == ">3"
            over_performance = "TOP 1%"
          elsif aa1 == "5-10" or aa2 == "2-3" or aa3 == "2-3"
            over_performance = "TOP 1%"
          elsif aa1 == "3-5" or aa2 == "1-2" or aa3 == "1-2"
            over_performance = "TOP 5%"
          else
            over_performance = "NOT TOP 10%"
          end
        end
        #
        #                                                        综合业绩分类: 其他
        #
        # 从事的投资机构类型？	D
        # AND
        # 已退出项目合计回报倍数？(现金或股价计）	>10	5-10	3-5	<3	FLOAT
        # AND
        # 已退出项目合计数量？	>10	5-10	3-5	<3	INT
        #
        # 综合业绩分类: 其他	TOP 5%	TOP 10%	NOT Top 10%	NOT Top 10%
        if a1 == "OTHER"


          if a11 == ">10" and q7 == ">10"
            over_performance = "TOP 5%"
          elsif a11 == "5-10" and q7 == "5-10"
            over_performance = "TOP 10%"
          elsif a11 == "3-5" and q7 = "3-5"
            over_performance = "NOT TOP 10%"
          else
            over_performance = "NOT TOP 10%"
          end
        end

        @result = "问卷调查完成!"
        m = @attempt_builder.to_model
        m.tag_list.add("投资经验分类: #{exp}<br> 投资经验分类: #{exit_rate}<br> 综合业绩分类: #{over_performance}")
        m.save
        Rapidfire::Engine.routes.url_helpers.survey_attempt_path(@survey, m)
      end
    end


  end
end