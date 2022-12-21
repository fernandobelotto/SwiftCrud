import SwiftUI

struct ContentView: View {
    @State private var tasks = [Task]()
    @State private var newTaskTitle = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New task", text: $newTaskTitle)
                    Button(action: {
                        let task = Task(title: self.newTaskTitle)
                        self.tasks.append(task)
                        self.newTaskTitle = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                            .imageScale(.large)
                    }
                }
                .padding()

                List {
                    ForEach(tasks) { task in
                        HStack {
                            Text(task.title)
                            Spacer()
                            Button(action: {
                                let index = self.tasks.firstIndex(where: { $0.id == task.id })!
                                self.tasks[index].isCompleted.toggle()
                            }) {
                                if task.isCompleted {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundColor(.gray)
                                }
                            }
                            Button(action: {
                                let index = self.tasks.firstIndex(where: { $0.id == task.id })!
                                self.tasks.remove(at: index)
                            }) {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .onMove { indices, newOffset in
                        self.tasks.move(fromOffsets: indices, toOffset: newOffset)
                    }
                    .onDelete { indices in
                        self.tasks.remove(atOffsets: indices)
                    }
                }
            }
            .navigationBarTitle("Tasks")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct Task: Identifiable {
    let id = UUID()
    let title: String
    var isCompleted = false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
