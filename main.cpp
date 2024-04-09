#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FileSystem.h"

#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopPass.h"

#include "polly/PolyhedralInfo.h"
#include "polly/ScopInfo.h"

#include <fstream>

#include <assert.h>

using namespace llvm;
using namespace polly;

namespace {
class LoopInfoPass : public LoopPass {
public:
  static char ID;
  LoopInfoPass() : LoopPass(ID) {}

  virtual ~LoopInfoPass() {}

  bool runOnLoop(Loop *L, LPPassManager &LPM) override {
    PolyhedralInfo &PI = getAnalysis<PolyhedralInfo>();

    auto *S = PI.getScopContainingLoop(L);
    if (S)
    {
      dbgs() << "\tScop: " << S->getNameStr() << "\n";
    }
    else
    {
      dbgs() << "\tNo static control part found\n";
    }

    if (PI.isParallel(L))
    {
      dbgs()<<"\tParallel loop: "+L->getHeader()->getName()<<"\n";
    }
    else
    {
      dbgs()<<"\tNon-parallel loop: "+L->getHeader()->getName()<<"\n";
    }

    for (auto *BB : L->blocks()) {
        dbgs() << "\t\tBasic Block: " << BB->getName() << "\n";
        for (auto &I : *BB) {
            dbgs() <<"\t\t\t"<< I << "\n";
        }
    }

    dbgs() << "\n";

    return false;
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<PolyhedralInfo>();
    AU.setPreservesAll();
  }
};

} // namespace

char LoopInfoPass::ID = 0;

int main(int argc, char **argv)
{
  if (argc < 2)
  {
    errs() << "Usage: " << argv[0] << " <IR file>\n";
    return 1;
  }

  LLVMContext context;

  dbgs() << "Parsing IR file: " << argv[1] << "\n";

  SMDiagnostic err;
  std::unique_ptr<Module> program = parseIRFile(argv[1], err, context);
  if (!program)
  {
    err.print(argv[0], errs());
    return 1;
  }

  legacy::FunctionPassManager FPM(program.get());

  FPM.add(new LoopInfoPass());

  for (auto &F : *program)
  {
    if (F.isDeclaration())
      continue;
    dbgs() << "Function: " << F.getName() << "\n";
    FPM.run(F);
  }

  dbgs() << "Done\n";

  return 0;
}
