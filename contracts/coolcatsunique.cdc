import TopShot from 0x0b2a3299cc857e29

// Returns the total # of moments the user has from Cool Cats
pub fun main(account: Address): UInt64 {
  let collection = getAccount(account).getCapability(/public/MomentCollection)
                    .borrow<&{TopShot.MomentCollectionPublic}>()
                    ?? panic("Person doesn't have a TopShot Collection.")
  
  let ids = collection.getIDs()
  var answer: UInt64 = 0
  var coveredPlays: [UInt32] = []
  for id in ids {
    let moment = collection.borrowMoment(id: id)!
    if moment.data.setID == 32 && !coveredPlays.contains(moment.data.playID) {
      answer = answer + 1
      coveredPlays.append(moment.data.playID)
    }
  }
  return answer
}