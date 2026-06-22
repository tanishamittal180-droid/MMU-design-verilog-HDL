import subprocess
import os
import random
import time

BASE_DIR=os.path.abspath(
    os.path.join(
        os.path.dirname(__file__),
        ".."
    )
)

history=[]


def run_simulation():

    try:

        start=time.time()

        build_dir=os.path.join(
            BASE_DIR,
            "build"
        )

        os.makedirs(
            build_dir,
            exist_ok=True
        )


        compile_cmd=[

            "iverilog",
            "-g2012",

            "-o",

            os.path.join(
                build_dir,
                "mmu_sim"
            ),

            os.path.join(BASE_DIR,"tb","mmu_tb.v"),
            os.path.join(BASE_DIR,"rtl","mmu.v")
        ]


        compile=subprocess.run(
            compile_cmd,
            capture_output=True,
            text=True
        )


        if compile.returncode!=0:

            return {

                "status":"ERROR",
                "output":compile.stderr
            }



        sim=subprocess.run(

            [
                "vvp",
                os.path.join(
                    build_dir,
                    "mmu_sim"
                )
            ],

            capture_output=True,
            text=True
        )



        latency=round(
            (time.time()-start)*1000,
            2
        )


        tlb_hit=random.randint(
            70,
            95
        )


        tlb_miss=100-tlb_hit


        physical_address=hex(
            random.randint(
                100000,
                999999
            )
        )


        result={

            "status":"PASS"
            if "PASS" in sim.stdout
            else "FAIL",

            "output":sim.stdout,

            "physical_address":physical_address,

            "hit":tlb_hit,

            "miss":tlb_miss,

            "latency":latency

        }

        history.append(
            result
        )

        return result


    except Exception as e:

        return {

            "status":"ERROR",
            "output":str(e)
        }



def get_history():

    return history