"""Project pipelines."""
from typing import Dict

from kedro.pipeline import Pipeline

from .pipelines import data_collecting as dc
from .pipelines import data_processing as dp
from .pipelines import data_science as ds
from .pipelines import feature_engineering as fe
from .pipelines import training as train
from .pipelines import predicting as predict


def register_pipelines() -> Dict[str, Pipeline]:
    """Register the project's pipelines.

    Returns:
        A mapping from a pipeline name to a ``Pipeline`` object.

    """
    data_collecting_pipeline = dc.create_pipeline()
    data_processing_pipeline = dp.create_pipeline()
    feature_engineering_pipeline = fe.create_pipeline()
    training_pipeline = train.create_pipeline()
    predict_pipeline = predict.create_pipeline()
    data_science_pipeline = ds.create_pipeline()

    pipelines = {
        "data_collecting": data_collecting_pipeline,
        "data_processing": data_processing_pipeline,
        "feature_engineering": feature_engineering_pipeline,
        "training": training_pipeline,
        "predicting": predict_pipeline,
        "data_science": data_science_pipeline,
    }

    pipelines["__default__"] = sum(pipelines.values())

    return pipelines
