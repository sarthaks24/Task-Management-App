//
//  Home.swift
//  Slider
//
//  Created by Sarthak on 26/04/24.
//

import SwiftUI

struct Home: View {
    
    @State private var currentDate: Date = .init()
    @State var weekSlider: [[Date.WeekDay]] = []
    @State var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = false
    
    @State private var createNewTask: Bool = false
    //Animation NameSpace
    @Namespace private var animation
    
    @State private var taska: [Task] = createSampleTasks()

    
    //var sampleTasks: [Task] = createSampleTasks()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            HeaderView()
            
            ScrollView(.vertical){
                // Task View
                TasksView(currentDate: $currentDate)
                    .frame(width: 400)
                
            }
            .hSpacing(.center)
            .vSpacing(.center)
            
        })
        .vSpacing(.top)
        .overlay(alignment: .bottomTrailing, content: {
            Button(action: {
                createNewTask.toggle()
            }, label: {
                Image(systemName: "plus")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 55, height: 55)
                    .background(.blue, in: .circle)
            })
            .padding(15)
        })
        .onAppear(perform: {
            if weekSlider.isEmpty {
                let currentWeek = Date().fetchWeek()
                
                if let firstDate = currentWeek.first?.date {
                    weekSlider.append(firstDate.createPreviousWeek())
                }
                
                weekSlider.append(currentWeek)
                
                if let lastDate = currentWeek.last?.date {
                    weekSlider.append(lastDate.createNextWeek())
                }
                
                
                
            }
        })
        .sheet(isPresented: $createNewTask, content: {
            NewTaskView()
                .presentationDetents([.height(300)])
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
                .presentationBackground(.white)
        })

    }
    
    // Header View
    @ViewBuilder
    func HeaderView () -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 5) {
                Text(currentDate.format(format: "MMMM"))
                    .foregroundStyle (.blue)
                Text(currentDate.format(format: "YYYY"))
                    .foregroundStyle(.gray)
            }
            .font(.title.bold())
            
            Text (currentDate.formatted (date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight( .semibold)
                .textScale(.secondary)
                .foregroundStyle(.gray)
            
            // Week Slider
            TabView(selection: $currentWeekIndex,
                    content:  {
                ForEach(weekSlider.indices, id: \.self) {index in
                    let week  = weekSlider[index]
                    
                    weekView(week).tag(index)
                }
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 90)

        }
        .hSpacing(.leading)
        .overlay(alignment: .topTrailing, content: {
            Button(action: {}, label: {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(.circle)
                    .foregroundColor(.blue)
            })
        })
        .padding(15)
        .background(.white)
        .onChange(of: currentWeekIndex, initial: false){ oldValue, newValue in
            if newValue == 0 || newValue == (weekSlider.count - 1){
                createWeek = true
            }
            
        }

    }
    
    // Week View
    @ViewBuilder
    func weekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0){
            ForEach(week) { day in
                VStack(spacing: 0) {
                    Text(day.date.format(format: "E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    Text(day.date.format(format: "dd"))
                        .font(.system(size: 20) )
                        .frame(width: 50, height: 55)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .black)
                        .background(content: {
                            if isSameDate(day.date, currentDate){
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.black)
                                    .offset(y: 3)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                            }
                            
                            if day.date.isToday{
                                Circle()
                                    .fill(.yellow)
                                    .frame (width: 5, height: 5)
                                    .vSpacing (.bottom)
                            }
                        })
                }
                .hSpacing(.center)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy){
                        currentDate = day.date
                    }
                }
            }
            
        }
        .background {
            GeometryReader{
                let minX = $0.frame(in: .global).minX
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self, perform: { value in
                        if value.rounded() == 15 && createWeek{
                            print("Generate")
                            paginateWeek()
                            createWeek = false
                        }
                        
                    })
            }
        }
    }
    

    
    func paginateWeek(){
        if weekSlider.indices.contains(currentWeekIndex){
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1) {
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
            }
        }
    }
    
    

}



    

#Preview {
    ContentView()
}

