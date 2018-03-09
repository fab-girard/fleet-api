class DepartureWorkflow < Workflow
  def initialize(company, options = {})
    super
  end

  def self.initial_mission_status(company)
    MissionStatusType.find_by('departure_to_do', company.id)
  end

  protected

  def create_workflow(company, status_types)
    # Mission action types
    # to do => loading
    # to do => gone
    MissionActionType.create(company: company, label: nil, previous_mission_status_type: status_types[:todo_status_type], next_mission_status_type: status_types[:loading_status_type])
    MissionActionType.create(company: company, label: nil, previous_mission_status_type: status_types[:todo_status_type], next_mission_status_type: status_types[:gone_status_type])
    # loading => gone
    MissionActionType.create(company: company, label: nil, previous_mission_status_type: status_types[:loading_status_type], next_mission_status_type: status_types[:gone_status_type])
    # gone => loading
    MissionActionType.create(company: company, label: nil, previous_mission_status_type: status_types[:gone_status_type], next_mission_status_type: status_types[:loading_status_type])
  end

  def create_mission_status_types(company)
    todo_status_type = MissionStatusType.create(company: company, reference: 'departure_to_do', label: 'To do', color: '#337AB7', svg_path: 'm 9.14286,118.85713 20.57143,0 0,-20.571428 -20.57143,0 0,20.571428 z m 25.14286,0 22.85714,0 0,-20.571428 -22.85714,0 0,20.571428 z M 9.14286,93.714272 l 20.57143,0 0,-22.85714 -20.57143,0 0,22.85714 z m 25.14286,0 22.85714,0 0,-22.85714 -22.85714,0 0,22.85714 z m -25.14286,-27.42857 20.57143,0 0,-20.57143 -20.57143,0 0,20.57143 z m 52.57143,52.571428 22.85714,0 0,-20.571428 -22.85714,0 0,20.571428 z m -27.42857,-52.571428 22.85714,0 0,-20.57143 -22.85714,0 0,20.57143 z m 54.85714,52.571428 20.57143,0 0,-20.571428 -20.57143,0 0,20.571428 z m -27.42857,-25.142858 22.85714,0 0,-22.85714 -22.85714,0 0,22.85714 z m -25.14286,-61.71428 0,-20.57143 q 0,-0.92857 -0.67858,-1.6071396 -0.67856,-0.67857 -1.60713,-0.67857 l -4.57143,0 q -0.92856,0 -1.60715,0.67857 -0.67857,0.6785696 -0.67857,1.6071396 l 0,20.57143 q 0,0.92857 0.67857,1.60714 0.67859,0.67857 1.60715,0.67857 l 4.57143,0 q 0.92857,0 1.60713,-0.67857 0.67858,-0.67857 0.67858,-1.60714 z m 52.57143,61.71428 20.57143,0 0,-22.85714 -20.57143,0 0,22.85714 z m -27.42857,-27.42857 22.85714,0 0,-20.57143 -22.85714,0 0,20.57143 z m 27.42857,0 20.57143,0 0,-20.57143 -20.57143,0 0,20.57143 z m 2.285721,-34.28571 0,-20.57143 q 0,-0.92857 -0.678571,-1.6071396 -0.67858,-0.67857 -1.60715,-0.67857 l -4.57143,0 q -0.92857,0 -1.60713,0.67857 -0.67859,0.6785696 -0.67859,1.6071396 l 0,20.57143 q 0,0.92857 0.67859,1.60714 0.67856,0.67857 1.60713,0.67857 l 4.57143,0 q 0.92857,0 1.60715,-0.67857 0.678571,-0.67857 0.678571,-1.60714 z m 27.428569,-4.57143 0,91.428568 q 0,3.71428 -2.71429,6.42858 -2.71429,2.71428 -6.42857,2.71428 l -100.57143,0 q -3.71428,0 -6.42857,-2.71428 Q 0,122.57141 0,118.85713 L 0,27.428562 q 0,-3.71429 2.71429,-6.42857 2.71429,-2.71429 6.42857,-2.71429 l 9.14286,0 0,-6.85714 q 0,-4.7142896 3.35715,-8.0714296 Q 25,-7.6293954e-6 29.71429,-7.6293954e-6 l 4.57143,0 q 4.71428,0 8.07143,3.3571400293954 3.35715,3.35714 3.35715,8.0714296 l 0,6.85714 27.42857,0 0,-6.85714 q 0,-4.7142896 3.35714,-8.0714296 Q 79.85715,-7.6293954e-6 84.57143,-7.6293954e-6 l 4.57143,0 q 4.714281,0 8.071421,3.3571400293954 3.357159,3.35714 3.357159,8.0714296 l 0,6.85714 9.14285,0 q 3.71428,0 6.42857,2.71429 2.71429,2.71428 2.71429,6.42857 z')
    loading_status_type = MissionStatusType.create(company: company, reference: 'departure_loading', label: 'Loading', color: '#F0AD4E', svg_path: 'M 26.18182,-3.8146973e-6 C 18.96972,-3.8146973e-6 12.80232,2.5599462 7.68113,7.6811358 2.55994,12.802326 0,18.969726 0,26.181816 l 0,75.636364 c 0,7.2121 2.55994,13.37731 7.68113,18.4985 C 12.80232,125.43787 18.96972,128 26.18182,128 l 75.63637,0 c 7.21209,0 13.3773,-2.56213 18.4985,-7.68332 C 125.43787,115.19549 128,109.03028 128,101.81818 l 0,-75.636364 c 0,-7.21209 -2.56213,-13.37949 -7.68331,-18.5006802 C 115.19549,2.5599462 109.03028,-3.8146973e-6 101.81819,-3.8146973e-6 l -75.63637,0 z m 0,11.6363698146973 75.63637,0 c 3.99998,0 7.42288,1.42343 10.27136,4.27191 2.84847,2.84847 4.27409,6.27356 4.27409,10.27354 l 0,75.636364 c 0,3.99998 -1.42562,7.42289 -4.27409,10.27136 -2.84848,2.84848 -6.27138,4.2741 -10.27136,4.2741 l -75.63637,0 c -3.99999,0 -7.42508,-1.42562 -10.27355,-4.2741 -2.84847,-2.84847 -4.27191,-6.27138 -4.27191,-10.27136 l 0,-75.636364 c 0,-3.99998 1.42344,-7.42507 4.27191,-10.27354 2.84847,-2.84848 6.27356,-4.27191 10.27355,-4.27191 z m 5.32023,14.6481 c -0.31987,-0.0243 -0.61511,0.0455 -0.88234,0.20748 -0.53445,0.32391 -0.80153,0.90503 -0.80153,1.7472 l 0,71.519518 c 0,0.842166 0.26708,1.425476 0.80153,1.749386 0.53445,0.32391 1.17474,0.27694 1.91974,-0.14415 L 97.06362,65.506966 c 0.74499,-0.42109 1.11601,-0.92393 1.11601,-1.50697 0,-0.58304 -0.37102,-1.08587 -1.11601,-1.50696 L 32.53945,26.636086 c -0.3725,-0.21054 -0.71754,-0.32733 -1.0374,-0.35162 z')
    gone_status_type = MissionStatusType.create(company: company, reference: 'departure_gone', label: 'Gone', color: '#5CB85C', svg_path: 'M 26.18183,0 C 18.96974,0 12.80233,2.55995 7.68115,7.6811396 2.55995,12.80233 0,18.96973 0,26.18182 l 0,75.63636 c 1e-5,7.21209 2.55995,13.3773 7.68115,18.49849 5.12118,5.12119 11.28859,7.68332 18.50068,7.68332 l 75.63635,0 c 7.2121,0 13.3795,-2.56213 18.50068,-7.68332 5.1212,-5.12119 7.68115,-11.2864 7.68115,-18.49849 l 0,-75.63636 c 0,-7.21209 -2.55995,-13.37949 -7.68115,-18.5006804 C 115.19768,2.55995 109.03028,0 101.81818,0 L 26.18183,0 Z m 0,11.63636 75.63635,0 c 3.99999,0 7.42508,1.42344 10.27355,4.27191 2.84848,2.84847 4.27191,6.27356 4.27191,10.27355 l 0,75.63636 c 1e-5,3.99997 -1.42343,7.42288 -4.27191,10.27135 -2.84847,2.84848 -6.27356,4.2741 -10.27355,4.2741 l -75.63635,0 c -3.99999,0 -7.42508,-1.42562 -10.27355,-4.2741 -2.84848,-2.84847 -4.27191,-6.27138 -4.27191,-10.27135 l 0,-75.63636 c -10e-6,-3.99999 1.42343,-7.42508 4.27191,-10.27355 2.84847,-2.84847 6.27356,-4.27191 10.27355,-4.27191 z m 64.20092,23.50205 c -1.29565,0 -2.39744,0.45368 -3.3044,1.36063 L 55.20503,68.42042 40.92166,54.089 c -0.90696,-0.90695 -2.00875,-1.36064 -3.3044,-1.36064 -1.29565,0 -2.39744,0.45369 -3.3044,1.36064 l -6.6066,6.6066 C 26.7993,61.60256 26.34562,62.70436 26.34562,64 c 0,1.29564 0.45368,2.39744 1.36064,3.30439 l 17.58776,17.58777 6.6088,6.60661 c 0.90694,0.90695 2.00657,1.36063 3.30221,1.36063 1.29564,0 2.39744,-0.45368 3.30439,-1.36063 l 6.60879,-6.60661 35.17554,-35.17772 c 0.90696,-0.90695 1.36064,-2.00657 1.36064,-3.30221 0,-1.29564 -0.45368,-2.39744 -1.36064,-3.30439 l -6.6066,-6.6088 c -0.90696,-0.90695 -2.00875,-1.36063 -3.3044,-1.36063 z')

    {
      todo_status_type: todo_status_type,
      loading_status_type: loading_status_type,
      gone_status_type: gone_status_type
    }
  end
end
