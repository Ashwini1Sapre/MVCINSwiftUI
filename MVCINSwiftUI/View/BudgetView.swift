//
//  BudgetView.swift
//  MVCINSwiftUI
//
//  Created by Knoxpo MacBook Pro on 02/04/21.
//

import Foundation
import SwiftOnoneSupport
import SwiftUI
import UIKit

struct BudgeView: View {
    
   @EnvironmentObject private var stateController: StateController
    @State private var addingNewTransaction = false
    
    var body: some View {
        
        NavigationView {
            
            AccountView(account: stateController.account)
                .navigationBarTitle("Budget")
                .navigationBarItems(trailing: Button(action: {
                    
                    self.addingNewTransaction = true
                    
                    
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                    
                    
                })
            
                .sheet(isPresented: $addingNewTransaction) {
                
                TransactionView()
                    .environmentObject(self.stateController)
                
                }
            
            
            
            
            
        }
        
        
        
    }
    
    
    
}







struct Balance: View {
    var amount: Int
    var body: some View {
        
        VStack(alignment: .leading)
            {
            
            Text("Balance")
                .font(.callout)
                .bold()
                .foregroundColor(.secondary)
            
            Text(amount.currencyFormat)
                .font(.largeTitle)
                .bold()
           
        }
        .padding(.vertical)
    }
    
}



struct AccountView: View {
    let account: Account
    
    private var transactions: [Badget.Transition] {
        return account
            .transactions
            .sorted(by: { $0.date > $1.date })
    }
    
    var body: some View {
        List {
            Balance(amount: account.balnce)
            ForEach(transactions) { transaction in
                Row(transation: transaction)
            }
        }
    }
}


struct Row: View {
    let transation: Transition
    
    var body: some View
    {
        
        HStack(spacing: 16.0) {
            CatrgoryView(category: transation.category)
            VStack(alignment: .leading, spacing: 4) {
                Text(transation.category.name)
                    .font(.callout)
                Text(transation.desciption)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
          Spacer()
           VStack(alignment: .trailing, spacing: 4) {
                Text(transation.amount.currencyFormat)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(transation.date.dateFormater)
                    .font(.title)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical)
       
    }
   
}







struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgeView()
    }
}
