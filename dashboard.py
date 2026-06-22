import streamlit as st
import pandas as pd
import plotly.express as px
import sys
import os

# Add project root path automatically
ROOT_DIR=os.path.abspath(
    os.path.join(
        os.path.dirname(__file__),
        ".."
    )
)

if ROOT_DIR not in sys.path:
    sys.path.insert(0,ROOT_DIR)


from backend.mmu_backend import (
    run_simulation,
    get_history
)


st.set_page_config(
    page_title="Advanced MMU Dashboard",
    layout="wide"
)


st.title("💾 Advanced MMU Dashboard")

st.markdown("---")


col1,col2=st.columns(2)

with col1:

    va=st.text_input(
        "Virtual Address",
        "0xCAFEBABE"
    )


with col2:

    access=st.selectbox(

        "Access Type",

        [
            "Load",
            "Store",
            "Instruction Fetch"
        ]
    )


if st.button("▶ Run MMU"):

    result=run_simulation()

    st.success(
        "Simulation Complete"
    )


    c1,c2,c3,c4=st.columns(4)

    c1.metric(
        "TLB Hit %",
        result.get(
            "hit",0
        )
    )

    c2.metric(
        "TLB Miss %",
        result.get(
            "miss",0
        )
    )

    c3.metric(
        "Latency(ms)",
        result.get(
            "latency",0
        )
    )

    c4.metric(
        "Physical Address",
        result.get(
            "physical_address",
            "N/A"
        )
    )


    st.markdown("---")


    st.subheader(
        "Simulation Output"
    )

    st.code(
        result.get(
            "output",
            ""
        )
    )


    history=get_history()

    if len(history)>0:

        st.subheader(
            "Translation History"
        )

        df=pd.DataFrame(
            history
        )

        st.dataframe(
            df,
            use_container_width=True
        )


        st.subheader(
            "TLB Performance"
        )

        fig=px.bar(
            df,
            x=df.index,
            y="hit"
        )

        st.plotly_chart(
            fig,
            use_container_width=True
        )


    if result.get(
        "status"
    )=="PASS":

        st.success(
            "✅ MMU Passed"
        )

    else:

        st.error(
            "❌ MMU Failed"
        )